class HistoryFilter
  attr_reader :history

  def changesets
    history.map(&:changeset)
  end

  def initialize(history)
    @history = history
  end

  def exclude(options={})
    exclusions = options.keys

    @history = history.select do |history_item|
      result = exclusions.inject(true) do |select, exclusion|
        history_item.changeset[exclusion] != options[exclusion]
      end
      result &= !yield(history_item) if block_given?
      result
    end
    clear_empty_changesets
    self
  end

  def include(options={})
    inclusions = options.keys

    @history = history.select do |history_item|
      result = inclusions.inject(true) do |select, inclusion|
        history_item.changeset[inclusion] == options[inclusion]
      end
      result &= yield(history_item) if block_given?
      result
    end
    clear_empty_changesets
    self
  end

  def merge(options)
    from_versions = []
    to_versions = []

    options.each_pair do |from, to|
      (from_versions << history.select { |h| h.version.item_type == from }).flatten!
      (to_versions << history.select { |h| h.version.item_type == to }).flatten!
    end

    from_versions.each_with_index do |history_item, index|
      history_item.changeset.each_pair do |key, value|
        if !["created_at", "updated_at"].include?(key) &&
            value.is_a?(Array) &&
            to_versions.size > index
          to_versions[index].changeset.merge!({ "#{key}" => value })
        end
      end
      exclude("object" => history_item.changeset["object"])
    end

    self
  end

  def remove(options)
    name = options["name"]

    @history = history.select do |history_item|
      history_item.changeset.delete_if { |key, value| name == key } if name
    end
    clear_empty_changesets
    self
  end

  def rename(options)
    object_key = options.keys.first
    object_value = options.values.first

    changesets.each do |changeset|
      object = changeset["object"]
      changeset["object"] = object_value if object == object_key
    end
    self
  end

  def transform(&blk)
    history.map(&blk)
    clear_empty_changesets
    self
  end

  def empty_changeset?(set)
    set.values.none? { |value| value.is_a? Array }
  end

  private

  def clear_empty_changesets
    history.delete_if { |history_item| empty_changeset?(history_item.changeset) }
  end
end