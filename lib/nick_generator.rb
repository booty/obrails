# frozen_string_literal: true

require "active_support"
require "active_support/core_ext"
require "faker"

module NickFakerRefinements
  STRIP_PUNCTUATION_REGEX = /[\!.'?]/.freeze

  refine String do
    def call
      self
    end

    def strip_punctuation
      gsub(STRIP_PUNCTUATION_REGEX, "")
    end

    def replace_whitespace_with(replacement_string)
      gsub(/\s/, replacement_string)
    end
  end

  refine Array do
    def sample2(char = nil)
      return(sample.call) if char.nil?

      temp_array = map(&:call)

      matches = temp_array.select { |x| x[0]&.downcase == char.downcase }

      # if matches.any?
      #   "[#{char}✔]#{matches.sample}"
      #   matches.sample
      # else
      #   "[#{char}ⅹ]#{sample}"
      # end

      matches.sample || sample
    end
  end
end

class NickFaker
  using NickFakerRefinements

  FRUITS = Array.new(50) { Faker::Food.fruits.downcase }
  BEER_BRANDS = Array.new(50) { Faker::Beer.brand.downcase }
  CANNABIS_WORDS = Array.new(25) { Faker::Cannabis.buzzword }
  COLORS = Array.new(50) { Faker::Color.color_name }
  EDUCATION_SUBJECTS = Array.new(50) { Faker::Educator.subject.downcase }
  PHILOSOPHERS = Array.new(50) { Faker::GreekPhilosophers.name.downcase }
  PHRASES = Array.new(100) { Faker::GreekPhilosophers.quote.strip_punctuation.split(" ").take(rand(2..7)).join(" ") } +
            Array.new(100) { Faker::Marketing.buzzwords.strip_punctuation.split(" ").take(rand(2..7)).join(" ") }
  EMPLOYMENT_TYPES = Array.new(25) { Faker::Job.employment_type }
  HACKER_ADJECTIVES = Array.new(25) { Faker::Hacker.adjective }
  HACKER_ING_VERBS = Array.new(25) { Faker::Hacker.ingverb }
  GAMES = Array.new(50) { Faker::Esport.game }
  ZELDA_ITEMS = Array.new(50) { Faker::Games::Zelda.item.downcase }
  FAKER_VERBS = Array.new(20) { Faker::Verb.base }
  FAKER_VERBS_PAST_PARTICIPLE = Array.new(50) { Faker::Verb.past_participle }
  FAKER_VERBS_ING = Array.new(50) { Faker::Verb.ing_form }
  CHARACTERS = Array.new(20) { Faker::Games::SonicTheHedgehog.character.downcase } +
               Array.new(20) { Faker::Games::Zelda.character.downcase } +
               Array.new(20) { Faker::Games::HalfLife.character.downcase } +
               Array.new(20) { Faker::Games::SuperSmashBros.fighter.downcase } +
               Array.new(20) { Faker::TvShows::RickAndMorty.character.downcase }
  ROOMS = Array.new(50) { Faker::House.room }
  ANIMALS = Array.new(100) { Faker::Creature::Animal.name.downcase }

  RESTAURANT_NAMES = [
      "pizza hut", "mcdonalds", "burger king", "taco bell", "white castle", "olive garden",
      "little caesars", "smashburger"
  ].freeze

  HONORIFIC_PREFIXES = %w[
    dr king lord lady queen master doc miss sir mistress
  ].freeze

  PRETENTIOUS_PREFIXES = [
    "lord", "god", "master", "king", "queen", "champion", "expert", "primo", "ace",
    "prince", "princess", "virtuoso", "genius", "hotshot", "superstar", "big league",
    "legend", "captain", "bigshot", "thee"
  ].freeze

  GAME_CONSOLES = [
    "atari", "intellivision", "colecovision", "master system", "commodore64", "amiga",
    "nintendo", "NES", "super nintendo", "SNES", "nintendo 64", "playstation", "playstation2",
    "playstation3", "xbox", "genesis", "game gear", "pc engine", "dreamcast", "sega saturn",
    "apple2", "xbox one"
  ].freeze

  ADJECTIVES = %w[
    sloppy kool sexy fuckable kawaii lonely crazy
    nymphomaniac schlerotic psychedelic cumguzzling nippled drunken
    mystic mysterious sensual erotic nappy
    throbbing turgid orgasmic slutty
    seething fighting cavorting caterwauling pregnant quarantined
    fuckable unfuckable titty-slappin secondhand squirting
    adaptable adventurous affable affectionate agreeable
    ambitious amiable amicable amusing brave bright
    broad-minded calm careful charming communicative
    compassionate conscientious considerate convivial courageous
    courteous creative decisive determined diligent diplomatic
    discreet dynamic easygoing emotional energetic enthusiastic
    exuberant faithful fearless forceful frank
    friendly funny generous gentle good gregarious
    hard-working helpful honest humorous imaginative impartial
    independent intellectual intelligent intuitive inventive
    kind loving loyal modest neat nice optimistic passionate
    patient persistent pioneering philosophical placid
    plucky polite powerful practical pro-active
    quick-witted quiet rational reliable reserved resourceful
    romantic self-confident self-disciplined sensible sensitive
    shy sincere sociable straightforward sympathetic thoughtful
    tidy tough unassuming understanding versatile warmhearted
    willing witty sexual unstoppable unfuckwithable
    aggressive aloof arrogant belligerent big-headed bitchy
    boastful bone-idle boring bossy callous cantankerous
    careless changeable clinging compulsive conservative cowardly
    cruel cunning cynical deceitful detached dishonest dogmatic
    domineering finicky flirtatious foolish foolhardy fussy greedy
    grumpy gullible harsh impatient impolite impulsive inconsiderate
    inconsistent indecisive indiscreet inflexible interfering intolerant
    irresponsible jealous lazy Machiavellian materialistic mean
    miserly moody narrow-minded nasty naughty nervous obsessive
    obstinate overcritical overemotional parsimonious patronizing perverse
    pessimistic pompous possessive pusillanimous quarrelsome quick-tempered
    resentful rude ruthless sarcastic secretive selfish self-centred
    self-indulgent silly sneaky stingy stubborn stupid superficial
    tactless timid touchy thoughtless truculent unkind unpredictable
    unreliable untidy untrustworthy vague vain vengeful vulgar weak-willed
    blissful brave careful cautious clever concentrated confident curious
    ecstatic excited fair fantastic friendly glad good great happy
    honest innocent interested joyful mediative nice optimistic pleasant
    quiet satisfied sensible serious surprised wonderful aggressive
    agonized angry annoyed arrogant awful bad bored confused
    crazy disappointed disbelieving disgusted enraged exhausted frightened
    frustrated grieving guilty hangover helpless horrified hurt
    hysterical idiotic indifferent lonely lovesick mad mischievous
    miserable nasty nervous puzzled sad sheepish shocked silly
    smug sorry strange stupid suspicious terrible jealous upset
  ].append(HACKER_ADJECTIVES).flatten.freeze

  VERBS_ING = %w[
    pooping jiggling fingering rubbing dominating glazing waxing sucking licking
    fisting frotting squirting cumming jizzing climaxing penetrating fingerbombing
    blowing kissing boobfucking assrimming talking pleasing whipping orgasming
    titfucking reacharounding tickling pounding teasing tasting ejaculating prolapsing
    cuckolding deepthroating deepdicking touching jerking plowing brutalizing
  ].append(HACKER_ING_VERBS).flatten.freeze

  VERBS = [
    "poop", "fuck", "smash", "fingerbang", "fingerblast", "hump", "chill", "penetrate",
    "rock out with", "murder", "bukkake", "jerk off", "touch", "blow", "thrill",
    "impregnate", "fight"
  ].append(FAKER_VERBS).flatten.freeze

  FANNISH_TITLES = %w[
    fan lvr lover slut addict master god stan
  ].freeze

  TITLES = [
    "pussypounder", "titfucker", "fartsucker", "gamer", "gyno", "assassin", "piss-slut",
    "cumgoblin", "vampire", "slut", "hobbit", "fucker", "wanker", "dancer", "stripper", "hobo",
    "hooker", "dragqueen", "gorilla", "kitten", "tramp",
    "stalker", "stud", "cosplayer", "streamer", "vlogger", "snatcher",
    "astronaut", "author", "baker", "barber", "beautician", "biologist", "bricklayer",
    "bus driver", "butcher", "caretaker", "carpenter", "chef", "chemist", "childcare assistant",
    "coach", "construction worker", "cook", "cosmetician", "customer adviser", "dentist", "doctor",
    "electrician", "engineer", "explorer", "farmer", "firefighter",
    "fitness instructor", "florist", "gardener", "glazier", "designer",
    "hairdresser hairstylist", "hunter/huntsman", "journalist", "magician", "mechanic",
    "miner", "nurse", "teacher", "painter", "paramedic", "physiotherapist",
    "pilot", "plumber", "policeman", "scientist", "roofer", "secretary",
    "shepherd", "shop assistant", "singer", "slater", "social worker", "surgeon",
    "cabdriver", "teacher", "thatcher", "tiler", "tourguide", "boxer", "killer", "fighter",
    "undertaker", "vet", "vocalist", "waitress", "zoologist"
  ].freeze

  FEELINGS_ABOUT = [
    "love", "hate", "want to kill", "want to fuck", "♥", "fancy", "dig", "breed",
    "worship", "bang", "cuddle", "dick", "fuck", "google", "hump", "irritate", "crave",
    "jerk off", "impregnate", "noogie", "necrotize", "oogle", "fist", "pluck", "ravish",
    "suck off", "squeeze", "cherish", "gangbang", "deepthroat", "pee on", "investigate"
  ].freeze

  BODY_PARTS = %w[
    ass pussy dick head face legs tits dick nipples pits
    cheeks face vag snatch twat cornhole ballsack beaver asshole
    boner butt buttcheek jugs vulva pubes elbows armpits snatch
    cervix clit gspot
  ].freeze

  BOOKENDS = [
    ["x ", " x"],
    ["-", "-"],
    ["-", "-"],
    ["-", "-"],
    ["", "!"],
    ["~", "~"],
  ].freeze

  POSSESSIVE_PRONOUNS = %w[
    my your his her yr
  ].freeze

  INVITATIONS = [
    "lets", "you should", "we should", "lets go", "gotta", "we will", "i will"
  ].freeze

  ALCOHOL_CONSUMPTION_VERBS = %w[
    chugging drinking drinkin sippin kegstanding shotgunning
    quaffing imbibing swilling guzzling sucking belting swigging
    pounding
  ].freeze

  BODILY_FLUIDS = %w[
    tears cum jizz pee poop juice semen cumm nut sweat
  ].freeze

  ALCOHOLIC_DRINKS = %w[
    beer vodka gin rum cognac tequila schnapps mezcal
    ale cider lager wine absinthe brandy whiskey bourbon
    soju sambuca jugwine eggnog grog hobopiss
  ].freeze

  FLUIDS = BODILY_FLUIDS + BEER_BRANDS + ALCOHOLIC_DRINKS + [
    -> { "#{ADJECTIVES.sample} #{BODILY_FLUIDS.sample}" },
  ].freeze

  GENERIC_FLUIDS = BODILY_FLUIDS + ALCOHOLIC_DRINKS

  SUFFIXES = [
    "420", "69", "X", -> { rand(100..9999) }
  ].freeze

  FLUIDS_COMPOUND_SUFFIXES = [
    "-covered", "-drenched", "-filled", "-hungry", "-addicted", "-crazed", "-glazed"
  ].freeze

  KINKS = %w[
    assplay
    pissplay
    anal
    barebacking
    ageplay
    nippletorture
    titplay
    cockworship
    enema
    frotting
    throatfucking
    creampies
    necrophilia
    rimming
    gangbang
    pussyworship
    scissoring
    doublepenetration
    pegging
    beastiality
    submission
    footjob
    handjob
    shibari
    titfucking
    watersports
  ].freeze

  AND_WORDS = [
    " and ", "-n-", "~and~", "+", "and", "and"
  ].freeze

  INTOXICATION_STATES = %w[
    buzzed smashed high sloshed drunk hammered shitfaced tipsy
    plastered intoxicated wasted
  ].freeze

  TEMPLATES = [
    ->(c) { "#{HONORIFIC_PREFIXES.sample2(c).call} #{TITLES.sample2(c).call}" },
    ->(c) { "#{['i ', ''].sample2(c)}#{FEELINGS_ABOUT.sample2(c).call} #{TITLES.sample2(c).call.pluralize}" },
    ->(c) { "#{ADJECTIVES.sample2(c).call} #{NOUNS.sample2(c).call}" },
    ->(c) { "#{ADJECTIVES.sample2(c).call} #{TITLES.sample2(c).call}" },
    ->(c) { "#{GAMES.sample2(c).call} #{FANNISH_TITLES.sample2(c).call}" },
    ->(c) { "#{VERBS_ING.sample2(c).call} #{POSSESSIVE_PRONOUNS.sample2(c).call} #{NOUNS.sample2(c).call}" },
    ->(_c) { PHRASES.sample.to_s },
    ->(c) { "#{COLORS.sample2(c)} #{PHILOSOPHERS.sample2(c)}" },
    ->(c) { "#{EMPLOYMENT_TYPES.sample2(c)} #{ADJECTIVES.sample2(c)}" },
    ->(c) { "#{BEER_BRANDS.sample2(c)} #{PHILOSOPHERS.sample2(c)}" },
    ->(c) { "#{ZELDA_ITEMS.sample2(c)} in #{POSSESSIVE_PRONOUNS.sample} #{BODY_PARTS.sample2(c)}" },
    ->(c) { "#{INVITATIONS.sample2(c)} #{VERBS.sample2(c)}" },
    ->(c) { "#{['will ', ''].sample}#{VERBS.sample2(c)}#{[' ', ' you '].sample}#{%w[for at].sample} #{RESTAURANT_NAMES.sample2(c)}" },
    ->(c) { "#{FEELINGS_ABOUT.sample2(c)}#{[' ', ' you '].sample}#{%w[for at].sample} #{RESTAURANT_NAMES.sample2(c)}" },
    ->(_c) { CHARACTERS.sample.to_s },
    ->(c) { "#{VERBS_ING.sample2(c)} #{CHARACTERS.sample2(c)}" },
    ->(c) { "#{CHARACTERS.sample2(c)} #{FANNISH_TITLES.sample2(c)}" },
    ->(c) { "#{EDUCATION_SUBJECTS.sample2(c)} #{TITLES.sample2(c)}" },
    ->(c) { "#{VERBS_ING.sample2(c)} in #{POSSESSIVE_PRONOUNS.sample} #{ROOMS.sample2(c)}" },
    ->(_c) { "#{ALCOHOL_CONSUMPTION_VERBS.sample} #{FLUIDS.sample}" },
    ->(_c) { "#{GENERIC_FLUIDS.sample}#{FLUIDS_COMPOUND_SUFFIXES.sample}" },
    ->(c) { "#{GENERIC_FLUIDS.sample2(c)}#{TITLES.sample2(c)}" },
    ->(c) { "#{KINKS.sample2(c)}#{AND_WORDS.sample}#{VERBS_ING.sample2(c)}" },
    ->(_c) { "#{KINKS.sample} #{FANNISH_TITLES.sample}" },
    ->(c) { "#{KINKS.sample2(c)} #{%w[with for].sample} #{CHARACTERS.sample2(c)}" },
    ->(_c) { "#{RESTAURANT_NAMES.sample}#{AND_WORDS.sample}#{KINKS.sample}" },
    ->(_c) { "#{POSSESSIVE_PRONOUNS.sample} #{GENERIC_FLUIDS.sample}#{FLUIDS_COMPOUND_SUFFIXES.sample} #{ROOMS.sample}" },
    ->(c) { "#{KINKS.sample2(c)} #{PHILOSOPHERS.sample2(c)}" },
    ->(c) { "#{PRETENTIOUS_PREFIXES.sample2(c)} of #{(GAMES + KINKS + VERBS_ING).sample2(c)}" },
    ->(c) { "#{ADJECTIVES.sample2(c)} #{ANIMALS.sample2(c)}" },
    ->(c) { "#{FAKER_VERBS_ING.sample2(c)} #{ANIMALS.sample2(c)}" },
    ->(c) { "#{FAKER_VERBS_ING.sample2(c)} #{ADJECTIVES.sample2(c)} #{ANIMALS.sample2(c)}" },
    ->(c) { "#{FLUIDS.sample2(c)} #{ANIMALS.sample2(c)}" },
    ->(c) { "#{COLORS.sample2(c)} #{ANIMALS.sample2(c)}" },
    ->(c) { "#{ANIMALS.sample2(c)} #{BODY_PARTS.sample2(c)}" },
    ->(c) { "#{KINKS.sample2(c)} #{ANIMALS.sample2(c)}" },
    ->(c) { "#{ALCOHOL_CONSUMPTION_VERBS.sample2(c)} #{ANIMALS.sample2(c)} #{BODILY_FLUIDS.sample2(c)}" },
    ->(c) { "#{CANNABIS_WORDS.sample2(c)} #{(ANIMALS + GAME_CONSOLES).sample2(c)}" },
    ->(c) { "#{CANNABIS_WORDS.sample2(c)} #{CHARACTERS.sample2(c)}" },
    ->(c) { "#{ADJECTIVES.sample2(c)} #{CANNABIS_WORDS.sample2(c)} #{ANIMALS.sample2(c)} #{PRETENTIOUS_PREFIXES.sample2(c)}" },
    ->(_c) { "#{%w[PM_ME SHOW_ME POST].sample}_YOUR_#{BODY_PARTS.sample.upcase}#{['', '', '', '', '', '', '_THX', '_PLZ'].sample}" },
    ->(c) { "#{GAMES.sample2(c)} #{AND_WORDS.sample} #{ALCOHOL_CONSUMPTION_VERBS.sample2(c)} #{(ALCOHOLIC_DRINKS + BODILY_FLUIDS).sample}" },
    ->(c) { "#{INTOXICATION_STATES.sample2(c)} on #{FLUIDS.sample2(c)}" },
    ->(c) { "#{VERBS_ING.sample2(c)} #{(PRETENTIOUS_PREFIXES + FANNISH_TITLES).sample2(c)}" },
    ->(c) { "#{FAKER_VERBS.sample2(c)} #{POSSESSIVE_PRONOUNS.sample} #{ANIMALS.sample2(c)}" },
    ->(c) { "#{INVITATIONS.sample} #{VERBS.sample2(c)} #{(ANIMALS + TITLES).sample2(c).pluralize}" },
    ->(c) { "#{PRETENTIOUS_PREFIXES.sample2(c)} #{(COLORS + ADJECTIVES).sample2(c)}" },
    ->(c) { "i #{FEELINGS_ABOUT.sample2(c)} #{ANIMALS.sample2(c).pluralize}" },
    ->(c) { "#{VERBS_ING.sample2(c)} #{%w[not then after before while].sample} #{VERBS_ING.sample2(c)}" },
    ->(_c) { "#{INVITATIONS.sample} play #{GAME_CONSOLES.sample}" },
    ->(c) { "#{GAME_CONSOLES.sample2(c)} #{AND_WORDS.sample2(c)} #{(KINKS + VERBS_ING).sample2(c)}" },
  ].freeze

  def self.decorate(string)
    step_one = case rand(5..10)
               when 5
                 string.replace_whitespace_with("~")
               when 6..7
                 string.titleize.replace_whitespace_with("")
               when 8
                 string.replace_whitespace_with("_")
               when 9
                 bookends = BOOKENDS.sample
                 "#{bookends[0]}#{string}#{bookends[1]}"
               when 10
                 "#{string.replace_whitespace_with('').downcase}#{SUFFIXES.sample2}"
               else
                 string.downcase
               end

    case rand(1..3)
    when 1..2
      step_one.replace_whitespace_with(["-", "", ".", "-", "-"].freeze.sample)
    else
      step_one
    end
  end

  def self.render
    alliterative_letters = "abcccccdeeeefghijklmnopqrrrrsssssttttuvwxyz"
    alliterative_attempt = alliterative_letters[rand(0..alliterative_letters.length + 10)]

    template = TEMPLATES.sample.call(alliterative_attempt)

    decorate(template)
  end
end

25.times do
  puts NickFaker.render
end
