class PartitionObserver < ActiveRecord::Observer
  def after_create(partition)
    create_statistics_for_partition partition
  end
  
  def after_destroy(partition)
    destroy_statistics_from_partition partition
  end
  
  private
  
  def create_statistics_for_partition(partition)
    Affair.players_on_season(partition.season_id).each do |affair|
      Statistic.find_or_create_by_member_id_and_partition_id(affair.member_id, partition.id)
    end
  end
  
  def destroy_statistics_from_partition(partition)
    Statistic.where('partition_id = ?', partition.id).each do |statistic|
      statistic.destroy
    end
  end
end
