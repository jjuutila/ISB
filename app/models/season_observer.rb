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
    if object.class == Affair
      affair_updated object
    end
  end
  
  def after_destroy(object)
    if object.class == Affair
      destroy_statistics_from_season object
    elsif object.class == Partition
      destroy_statistics_from_partition object
    end
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
  
  def affair_updated(affair)
    if affair.role == 'player'
      create_statistics_for_player affair
    elsif
      destroy_statistics_from_season affair
    end
  end
  
  def destroy_statistics_from_season(affair)
    partition_ids = Partition.in_season(affair.season_id).collect{|p| p.id}
    Statistic.where('partition_id IN (?) AND member_id = ?', partition_ids, affair.member_id).each do |statistic|
      statistic.destroy if statistic.all_0?
    end
  end
  
  def destroy_statistics_from_partition(partition)
    Statistic.where('partition_id = ?', partition.id).each do |statistic|
      statistic.destroy
    end
  end
end
