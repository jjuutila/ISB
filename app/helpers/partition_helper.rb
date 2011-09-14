module PartitionHelper
  def partition_content_link_list_for partition, &create_link
    partition_links = partition.season.partitions.collect { |p| link_to_unless(partition == p,
      p, create_link.call(p)) }
      
    partition_links.to_sentence(:words_connector => " | ", :two_words_connector => " | ",
      :last_word_connector => " | ").html_safe
  end
end
