namespace :import do
  desc "Loads sections from a YML file"
  task :sections => :environment do
    yml = load_yml "sections"
    yml.each do |section|
     puts Section.create(:name => section["name"], :slug => section["slug"], :parent_id => section["parent_id"])
    end
  end
  
  desc "Loads news from a XML file"
  task :news => :environment do
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

  desc "This drops the DB and loads the DB schema"
  task :reset => ['db:drop', 'db:schema:load']
  
  def load_yml file_name
    require 'yaml'
    YAML::load(File.open(File.join( RAILS_ROOT, 'db', 'data', "#{file_name}.yml")))
  end
  
  def load_xml file_name
    Nokogiri::XML(File.open(File.join( RAILS_ROOT, 'db', 'data', "#{file_name}.xml")))
  end
end