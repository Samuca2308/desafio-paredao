
contestant_1 = Contestant.find_or_create_by(name: 'João')
contestant_2 = Contestant.find_or_create_by(name: 'Pedro')

puts "Created Contestants: #{contestant_1.name}, #{contestant_2.name}"

12.times do |i|
  ip_address = "192.168.1.#{i+1}"
  
  vote_session_1 = VoteSession.find_or_create_by(ip_address: ip_address)
  vote_session_1.votes.find_or_create_by(contestant: contestant_1)
  
  vote_session_2 = VoteSession.find_or_create_by(ip_address: ip_address)
  vote_session_2.votes.find_or_create_by(contestant: contestant_2)

  puts "Created vote for Contestant 1 and Contestant 2 from IP: #{ip_address}"
end