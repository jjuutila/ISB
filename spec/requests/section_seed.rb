# encoding: utf-8

miehet = SectionGroup.create :name => "Miehet", :are_players_male => true, :slug => "miehet"
naiset = SectionGroup.create :name => "Naiset", :are_players_male => false, :slug => "naiset"
pojat = SectionGroup.create :name => "Pojat", :are_players_male => true, :slug => "pojat"
tytot = SectionGroup.create :name => "Tytöt", :are_players_male => false, :slug => "tytot"

Section.create!([
  { :slug => "miehet-edustus", :group => miehet, :name => "Miehet edustus", :contact_info => nil, :picasa_user_id => "ISBilmajoki", :is_visible => true },
  { :slug => "miehet-ii", :group => miehet, :name => "Miehet II", :contact_info => nil, :picasa_user_id => nil, :is_visible => true },
  { :slug => "pojat-b", :group => pojat, :name => "B-Pojat", :contact_info => nil, :picasa_user_id => nil, :is_visible => false },
  { :slug => "pojat-c1", :group => pojat, :name => "C1-Pojat", :contact_info => nil, :picasa_user_id => nil, :is_visible => true },
  { :slug => "pojat-d", :group => pojat, :name => "D-Pojat", :contact_info => nil, :picasa_user_id => nil, :is_visible => true },
  { :slug => "naiset-edustus", :group => naiset, :name => "Naiset edustus", :contact_info => nil, :picasa_user_id => nil, :is_visible => true },
  { :slug => "tytot-b", :group => tytot, :name => "B-Tytöt", :contact_info => nil, :picasa_user_id => nil, :is_visible => true },
  { :slug => "miehet-iii", :group => miehet, :name => "Miehet III", :contact_info => nil, :picasa_user_id => nil, :is_visible => true },
  { :slug => "pojat-c2", :group => pojat, :name => "C2-Pojat", :contact_info => nil, :picasa_user_id => nil, :is_visible => true },
  { :slug => "tytot-c", :group => tytot, :name => "C-Tytöt", :contact_info => nil, :picasa_user_id => nil, :is_visible => true },
  { :slug => "tytot-d", :group => tytot, :name => "D-Tytöt", :contact_info => nil, :picasa_user_id => nil, :is_visible => true },
  { :slug => "naiset-ii", :group => naiset, :name => "Naiset II", :contact_info => nil, :picasa_user_id => nil, :is_visible => true }
], :without_protection => true )
