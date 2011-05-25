require 'cgi'
    
namespace :import do
  desc "Loads sections from a YML file"
  task :sections => :environment do
    puts "Loading SECTIONS"
    yml = load_yml "sections"
    yml.each do |section|
     puts Section.create(:name => section["name"], :slug => section["slug"], :parent_id => section["parent_id"])
    end
  end
  
  desc "Loads news from a XML file"
  task :news => :environment do
    puts "Loading NEWS"
    news_post = nil
    
    xml = load_xml "news"
    news_nodes = xml.xpath("//News")
    
    news_nodes.each do |news_node|
      title = news_node.children.css("Title").text()
      content = news_node.children.css("Content").text()
      created_at = news_node.children.css("AddTime").text()
      section_id = news_node.children.css("SectionID").text()
      
      begin
        section = Section.find section_id
        
        if !news_post.nil? and news_post.title == title and news_post.content == content
          # It is a duplicate, add section
          news_post.sections << section
          news_post.save
          puts "Added section for: #{news_post}"
        else
          # It is not a duplicate, create a new
          news_post = News.create(:title => title, :content => content, :created_at => created_at,
            :updated_at => created_at, :sections => [section])
          puts "Created new: #{news_post}"
        end
      rescue ActiveRecord::RecordNotFound
        puts "Section #{section_id} not found!"
      end
    end
  end
  
  desc "Loads members from a YML file"
  task :members => :environment do
    puts "Loading MEMBERS"
    yml = load_yml "players"
    
    yml.each do |player|
      position = 0
      
      # Transform position
      case player["Position"]
        when 1
          # Goalie
          position = 3
        when 2
          # Defender
          position = 2
        when 3
          # Attacker
          position = 1
        else
          position = 0
      end
      
      is_male = false
      if player["Gender"] == 0
        is_male = true
      end
      
      # Set birthyear to 1900 for those members which don't have a birtyear
      year = player["Birthyear"]
      if year < 1900
        year = 1900
      end
          
      member = Member.new(:first_name => player["FirstName"], :last_name => CGI.unescapeHTML(player["LastName"]),
        :number => player["Number"], :birth_year => year, :home_municipality => player["HomeMunicipality"],
        :all_time_goals => player["AlltimeGoals"], :all_time_assists => player["AlltimeAssists"], :position => position,
        :gender => is_male)
      
      if member.save
        puts "Saved member #{member}"
      else
        puts member.errors
      end
    end
  end
  
  desc "Loads guestbook comments from a XML file"
  task :guestbook => :environment do
    puts "Loading GUESTBOOK"
    
    xml = load_xml "guestbook"
    guestbook_nodes = xml.xpath("//GuestBook")
    
    guestbook_nodes.each do |node|
      author = node.children.css("Author").text()
      message = node.children.css("Message").text()
      section_id = node.children.css("SectionID").text()
      title = node.children.css("Title").text()
      date = node.children.css("WrittenOn").text()
      email = node.children.css("Email").text()
      ip = node.children.css("IpAddress").text()
      
      begin
        section = Section.find section_id
        guestbook_post = section.comments.build(:commentable_type => 'Section', :title => title, :content => message,
          :email => email, :created_at => date, :updated_at => date, :author => author, :ip_addr => ip)
        
        if guestbook_post.save
          puts "Save OK: #{date}"
        else
          puts "Discard post: #{guestbook_post.errors}"
        end
      rescue ActiveRecord::RecordNotFound
        puts "ERROR: Section #{section_id} not found!"
      end
    end
  end
  
  desc "Loads seasons from a YML file"
  task :seasons => :environment do
    puts "Loading SEASONS"
    yml = load_yml "seasons"
    
    yml.each do |season|
      begin
        section = Section.find season["SectionID"]
        
        new_season = Season.new(:division => season["Division"], :history => season["History"], :start_year => season["StartingYear"],
          :section => section)
          
        if new_season.save
          puts "Save OK: #{new_season}"
        else
          puts "Errors: #{new_season.errors}"
        end
      rescue ActiveRecord::RecordNotFound
        puts "ERROR: Section #{season["SectionID"]} not found!"
      end
    end
  end
  
  desc "Loads season partitions from a YML file"
  task :partitions => :environment do
    puts "Loading partitions"
    yml = load_yml "season_portions"
    
    yml.each do |partition_data|
      begin
        season = Season.find_by_division_and_start_year! partition_data["Division"], partition_data["StartingYear"]
        
        partition = season.partitions.build(:name => partition_data["Name"], :position => partition_data["OrderNumber"])
          
        if partition.save
          puts "Save OK: #{season} - #{partition}"
        else
          puts "Errors: #{partition.errors}"
        end
      rescue ActiveRecord::RecordNotFound
        puts "ERROR: Season #{partition_data["Division"]}: #{partition_data["StartingYear"]} not found!"
      end
    end
  end
  
  desc "Loads standings from standings.yml"
  task :standings => :environment do
    puts "Loading standings"
    yml = load_yml "standings"
    
    yml.each do |standings_data|
      begin
        season = Season.find_by_division_and_start_year! standings_data["Division"], standings_data["StartingYear"]
        partition = season.partitions.find_by_position! standings_data["OrderNumber"]
        
        team_standing = partition.team_standings.build :name => standings_data["TeamName"], :wins => standings_data["Wins"],
          :losses => standings_data["Losses"], :overtimes => standings_data["Overtime"], :goals_for => standings_data["GoalsFor"],
          :goals_against => standings_data["GoalsAgainst"]
          
        if team_standing.save
          puts "Save OK: #{season}, #{partition} - #{team_standing}"
        else
          puts "Errors: #{partition.errors}"
        end
      rescue ActiveRecord::RecordNotFound
        puts "ERROR: Problem with #{standings_data["Division"]}: #{standings_data["StartingYear"]} #{standings_data["OrderNumber"]}"
      end
    end
  end
  
  desc "Loads matches from matches.yml"
  task :matches => :environment do
    puts "Loading matches"
    yml = load_yml "matches"
    
    yml.each do |match_data|
      begin
        season = Season.find_by_division_and_start_year! match_data["Division"], match_data["StartingYear"]
        
        partition = season.partitions.find_by_position! match_data["OrderNumber"]
        
        home_team = partition.team_standings.find_by_name! match_data["HomeName"]
        visitor_team = partition.team_standings.find_by_name! match_data["VisitorName"]
        
        # Parse new match additional info from numerical format
        additional_info_as_number = match_data["AdditionalInfo"]
        if additional_info_as_number == 1
          additional_info = "overtime"
        elsif additional_info_as_number == 2
          additional_info = "shootout"
        else
          additional_info = nil
        end
        
        # Combine old MatchDate and StartTime fields into one variable
        date = match_data["MatchDate"].split '-'
        if match_data["StartTime"] # Some rows have null for StartTime
          time = match_data["StartTime"].split ':'
        else
          time = [nil, nil]
        end
        start_time = Time.local date[0], date[1], date[2], time[0], time[1]
        
        match = partition.matches.build :home_team => home_team, :visitor_team => visitor_team, :report => match_data["MatchReport"],
          :home_goals => match_data["HomeGoals"], :visitor_goals => match_data["VisitorGoals"], :location => match_data["Location"],
          :additional_info => additional_info, :start_time => start_time
        
        if match.save
          puts "Save OK: #{season} - #{match}: #{match.start_time}"
        else
          puts "Errors: #{match.errors}"
        end
      rescue ActiveRecord::RecordNotFound
        puts "ERROR: Problem with #{match_data["Division"]}: #{match_data["StartingYear"]} #{match_data["OrderNumber"]}"
      end
    end
  end
  
  desc "Loads statistics from statistics.yml"
  task :statistics => :environment do
    puts "Loading statistics"
    yml = load_yml "statistics"
    
    yml.each do |statistics_data|
      begin
        season = Season.find_by_division_and_start_year! statistics_data["Division"], statistics_data["StartingYear"]
        partition = season.partitions.find_by_position! statistics_data["OrderNumber"]
        member = Member.find_by_last_name_and_first_name! CGI.unescapeHTML(statistics_data["LastName"]), statistics_data["FirstName"]
        
        statistic = partition.statistics.build :member => member, :assists => statistics_data["Assists"],
          :goals => statistics_data["Goals"], :pim => statistics_data["PenaltyMinutes"], :matches => statistics_data["GamesPlayed"]
        
        if statistic.save
          puts "Save OK: #{season} - #{statistic}"
        else
          puts "Errors: #{statistic.errors}"
        end
      rescue ActiveRecord::RecordNotFound => e
        puts e
      end
    end
  end
  
  desc "Loads roles for members from roles.yml"
  task :roles => :environment do
    puts "Loading roles"
    yml = load_yml "roles"
    
    yml.each do |affair_data|
      begin
        season = Season.find_by_division_and_start_year! affair_data["Division"], affair_data["StartingYear"]
        member = Member.find_by_last_name_and_first_name! CGI.unescapeHTML(affair_data["LastName"]), affair_data["FirstName"]
        
        role_numerical = affair_data["Role"]
        
        case role_numerical
          when 1
            role = "player"
          when 2
            role = "coach"
          when 3
            role = "assistant"
          when 4
            role = "manager"
          else
            raise
        end

        affair = season.affairs.build :member => member, :role => role
        
        if affair.save
          puts "Save OK: #{season} - #{affair}"
        else
          puts "Errors: #{affair.errors}"
        end
      rescue ActiveRecord::RecordNotFound => e
        puts e
      end
    end
  end

  desc "Drops the database tables and then reloads the database schema"
  task :reset => ['db:drop', 'db:schema:load']
  
  desc "Loads all available data"
  task :all => [:sections, :news, :members, :guestbook, :seasons, :partitions, :standings, :matches, :statistics, :roles]
  
  def load_yml file_name
    require 'yaml'
    YAML::load(File.open(File.join( RAILS_ROOT, 'db', 'data', "#{file_name}.yml")))
  end
  
  def load_xml file_name
    require 'nokogiri'
    Nokogiri::XML(File.open(File.join( RAILS_ROOT, 'db', 'data', "#{file_name}.xml")))
  end
end