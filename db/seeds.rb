i = 0

2000.times do
  i += 1
  company_names = ["Gore", "Continental", "Abus", "Assos", "Selle Italia", "Castelli", "Chromag", "Cinelli", "Elite", "Ergon", "Haro", "Look", "Oakley", "Park Tools", "POC", "Salsa", "SRAM", "Syntace", "RockShox", "Canondale", "Matter Cycles", "Velocity Rims", "Time", "ENVE Composites", "Skratch Labs", "Shimano", "Autodesk", "Publix", "Mars", "Arnold & Porter", "Intel", "Microsoft", "EOG Resources", "Hitachi Data Systems", "Navy", "Four Seasons", "Nordstrom", "Capital One", "Hyatt Hotels", "Oracle", "Dell", "Novo", "REI", "Darden", "Container Store", "NuStar", "Gentech", "Salesforce", "Camden Property", "Walgreens", "Ultimate Software", "Ohio Medical Center", "Kimpton Hotels", "USAA", "Perkin Elmer", "Children’s Healthcare"]

  email_domains = ["gmail.dev", "yahoo.dev", "aol.dev"]
  surnames      = ["Smith","Johnson","Williams","Jones","Brown","Davis","Miller","Wilson","Moore","Taylor","Anderson","Thomas","Jackson","White","Harris","Martin","Thompson","Garcia","Martinez","Robinson","Clark","Rodiguez","Lewis","Lee","Walker","Hall","Allen","Young","Hernandez","King","Wright","Lopez","Hill","Scott","Green","Adams","Baker","Gonzalez","Nelson","Carter","Mitchell","Perez","Roberts","Turner","Phillips","Campbell","Parker","Evans","Edwards","Collins"]
  first_names   = ["James","John","Robert","Michael","William","David","Richard","Charles","Joseph","Thomas","Christopher","Daniel","Paul","Mark","Donald","George","Kenneth","Steven","Edward","Brian","Ronald","Anthony","Kevin","Jason","Jeff","Mary","Patricia","Linda","Barbara","Elizabeth","Jennifer","Maria","Susan","Margaret","Dorothy","Lisa","Nancy","Karen","Betty","Helen","Sandra","Donna","Carol","Ruth","Sharon","Michelle","Laura","Sarah","Kimberly","Deborah"]

  website_domain = company_names.sample.downcase.gsub(' ','-')

  first_name      = first_names.sample
  last_name       = surnames.sample
  name            = "#{first_name} #{last_name}"
  email           = "#{first_name}.#{last_name}.#{i}@#{email_domains.sample}".downcase
  website         = (rand(1..3) == 1 ? "http://#{website_domain}.dev" : nil)
  verified_at     = (rand(1..3) != 1 ? Time.zone.now - i.hours : nil)
  unsubscribed_at = (rand(1..10) == 1 ? Time.zone.now - i.hours : nil)
  ip_address      = "#{rand(1..300)}.#{rand(1..300)}.#{rand(1..300)}.#{rand(1..300)}"

  ## prevent emails from sending when seeding
  verification_sent_at = Time.zone.now - (i.hours + 1)

  Signatory.create(
    name: name,
    email: email,
    website: website,
    verified_at: verified_at,
    verification_sent_at: verification_sent_at,
    unsubscribed_at: unsubscribed_at,
    ip_address: ip_address
  )
end
