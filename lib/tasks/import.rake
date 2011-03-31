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
      if player["Gender"] == "0"
        is_male = true
      end
      
      # Set birthyear to 1900 for those members which don't have a birtyear
      year = player["Birthyear"]
      if year < 1900
        year = 1900
      end
          
      member = Member.create(:first_name => player["FirstName"], :last_name => player["LastName"], :number => player["Number"],
        :birth_year => year, :home_municipality => player["HomeMunicipality"], :all_time_goals => player["AlltimeGoals"],
        :all_time_assists => player["AlltimeAssists"], :position => position, :gender => is_male)
        
      puts "Saved member #{member}: #{member.valid?}"
      puts member.errors if member.errors.count > 0
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

  desc "This drops the DB and loads the DB schema"
  task :reset => ['db:drop', 'db:schema:load']
  
  desc "Loads all available data"
  task :all => [:sections, :news, :members, :guestbook, :seasons]
  
  def load_yml file_name
    require 'yaml'
    YAML::load(File.open(File.join( RAILS_ROOT, 'db', 'data', "#{file_name}.yml")))
  end
  
  def load_xml file_name
    require 'nokogiri'
    Nokogiri::XML(File.open(File.join( RAILS_ROOT, 'db', 'data', "#{file_name}.xml")))
  end
end