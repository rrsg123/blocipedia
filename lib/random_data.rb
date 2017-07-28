module RandomData

def self.random_name
	first_name = random_word.capitalize
	last_name = random_word.capitalize
	"#{first_name} #{last_name}"
end

def self.random_email
	"#{random_word}@#{random_word}.#{random_word}"
end


