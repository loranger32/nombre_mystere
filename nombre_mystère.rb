mystery_number = rand(0..100)
guess = ''
name = ''

puts "************************************".center(110)
puts "Bienvenue dans le jeu NOMBRE MYSTERE".center(110)
puts "************************************".center(110)

puts "Comment t'apples-tu ?"
loop do
  name = gets.chomp
  break unless (name.empty?) || (name =~ /\A\s+\z/)
  puts "Tu n'as rien entré, j'ai besoin d'un nom valide, recommence."
end

loop do
  attempts = 7
  puts ''
  puts "Ok #{name}, j'ai choisi un nombre entre 1 et 100."
  print "Essaie de le devnier, tu as droit à #{attempts} tentative(s): "
  guess = gets.to_i
  until (1..100).include?(guess)
    print "Tu n'as pas entré un numéro, ou bien le numéro est plus grand que 100, essaie encore: "
    guess = gets.to_i
  end
  attempts -= 1

  while guess != mystery_number && attempts >= 1
    if guess < mystery_number
      print "Le nombre mystère est plus grand, essaie encore #{name} (#{attempts} tentatives restantes): "
      guess = gets.to_i
      until (1..100).include?(guess)
        print "Tu n'as pas entré un numéro, ou bien le numéro est plus grand que 100, essaie encore: "
        guess = gets.to_i
      end
      attempts -= 1
    elsif guess > mystery_number
      print "Le nombre mystère est plus petit, essaie encore #{name} (#{attempts} tentatives restantes): "
      guess = gets.to_i
      until (1..100).include?(guess)
        print "Tu n'as pas entré un numéro, ou bien le numéro est plus grand que 100, essaie encore: "
        guess = gets.to_i
      end
      attempts -= 1
    end
  end

  if guess == mystery_number
    puts "Bravo #{name}, tu as trouvé le nombre mystère: #{mystery_number}!!!"
    puts "Tu as réussi en #{7 - attempts} coups!"
  else
    puts "Raté #{name}!!! Tu as épuisé toutes tes tentatives, tu as perdu!!!"
  end

  puts "Veux-tu faire une autre partie #{name} ('o' ou 'n')?"
  play_again = gets.chomp.downcase
  break if play_again == 'n'
  puts "Ok, on recommence!"
end

puts "Au revoir #{name}, à une prochaine fois !!"
