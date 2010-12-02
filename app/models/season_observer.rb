class SeasonObserver < ActiveRecord::Observer
  observe :affair, :partition
  
  def after_create(object)
    if object.class == Affair
      create_statistics_for_player object
    elsif object.class == Partition
      create_statistics_for_partition object
    end
  end
  
  def after_update(object)
    
  end
  
  def after_destroy(object)
    
  end
  
  private
  
  def create_statistics_for_player(affair)
    if affair.role == 'player'
      Partition.in_season(affair.season_id).each do |partition|
        Statistic.find_or_create_by_member_id_and_partition_id(affair.member_id, partition.id)
      end
    end
  end
  
  def create_statistics_for_partition(partition)
    Affair.players_on_season(partition.season_id).each do |affair|
      Statistic.find_or_create_by_member_id_and_partition_id(affair.member_id, partition.id)
    end
  end
end
