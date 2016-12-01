class Song
  attr_accessor :name, :artist_name
  @@all = []

  def self.all
    @@all
  end

  def self.create
    self.new.save
  end

  def self.new_by_name(name)
    song = self.new
    song.name = name
    song
  end

  def self.create_by_name(name)
    song = self.new_by_name(name)
    # song.name = name
    song.save
    song
  end 

  def self.find_by_name(name)
    self.all.detect do |song|
      song.name == name
    end
  end

  def self.find_or_create_by_name(name)
    self.find_by_name(name)? self.find_by_name(name) : self.create_by_name(name)
  end

  def self.alphabetical
    song = self.all.collect {|song_object| song_object.name}.sort
    song.collect {|song| self.find_by_name(song)}
  end


  def self.new_from_filename(filename)
    #"Thundercat - For Love I Come.mp3"
    array = filename.split(" - ")
    song = self.find_or_create_by_name(array[1].slice(0, array[1].length - 4))
    song.artist_name = array[0]
    song
  end

  def self.create_from_filename(filename)
    self.new_from_filename(filename).save
  end

  def self.destroy_all
    @@all = []
  end

  def save
    self.class.all << self
    self
  end

end
