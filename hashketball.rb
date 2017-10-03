require 'pry'
# Write your code here!
def data
  data = {"Brooklyn Nets"=> {colors:["Black","White"], players:
        {"Alan Anderson"=>[0,16,22,12,12,3,1,1],
         "Reggie Evans" => [30,14,12,12,12,12,12,7],
         "Brook Lopez" => [11,17,17,19,10,3,1,15],
         "Mason Plumlee" => [1,19,26,12,6,3,8,5],
         "Jason Terry" => [31,15,19,2,2,4,11,1]}},
        "Charlotte Hornets"=>{colors:["Turquoise","Purple"], players:
          {"Jeff Adrien" => [4,18,10,1,1,2,7,2],
           "Bismak Biyombo" => [0,16,12,4,7,7,15,10],
           "DeSagna Diop" => [2,14,24,12,12,4,5,5],
           "Ben Gordon" => [8,15,33,3,2,1,1,0],
           "Brendan Haywood" => [33,15,6,12,12,22,5,12]}}}
         end

def game
  hash = {home: {
    team_name: "",
    colors: [],
    players:{
      "" => {
        number: 0,
        shoe: 0,
        points: 0,
        rebounds: 0,
        assists: 0,
        steals: 0,
        blocks: 0,
        slam_dunks: 0
      }
    }
  },
  away: {
    team_name: "",
    colors: [],
    players:{
      "" => {
        number: 0,
        shoe: 0,
        points: 0,
        rebounds: 0,
        assists: 0,
        steals: 0,
        blocks: 0,
        slam_dunks: 0
      }
    }
  }
}
end
# receives keys structure for players and array of stats for each players
# it merges array with keys and returns, merged hash
def merge_player_info(keys,values)
 counter = 0
 players_hash = {}
  keys.each do |key|
    players_hash[key] = values[counter]
    counter += 1
  end
  players_hash
end

# receives key structure for players and hash containing name of player and array with stats
# merge array with stats with keys and returns new players_hash
def merge_players_info(keys,values_hash)

players_hash = {}
values_hash.each do |players, info|
  players_hash[players]= merge_player_info(keys,info)
end
players_hash
end

def populate_bulk(game_hash,data_array)
counter = 0
game_hash.keys.each do |team|
  game_hash[team].keys.each do |team_key|
    case team_key
    when :team_name
      game_hash[team][team_key] = data_array.keys[counter]
    when :colors
      game_hash[team][team_key] = data_array[data_array.keys[counter]][:colors]
    when :players
      players = game_hash[team][:players][""].keys
      stats_hash = data_array[data_array.keys[counter]][:players]
      game_hash[team][team_key] = merge_players_info(players,stats_hash)
    end # case 81
  end #do 80
  counter += 1
end # do 79
game_hash
end #def77

def game_hash
  populate_bulk(game, data)
end

def num_points_scored(player)
   score =0
   game_hash.values.each {|keys,values| keys[:players][player] ? score = keys[:players][player][:points]:nil}
   score
end

def shoe_size(player)
  shoe =0
  game_hash.values.each {|keys,values| keys[:players][player] ? shoe = keys[:players][player][:shoe]:nil}
  shoe
end

def team_colors(team)
  colors =[]
  game_hash.values.each {|keys| keys[:team_name] == team ? colors = keys[:colors]:nil}
  colors
end

def team_names
  game_hash.values.collect {|keys| keys[:team_name]}
end

def player_numbers(team)
  numbers =[]
  game_hash.values.each do |keys|
    if keys[:team_name] == team
       numbers = keys[:players].values.collect {|keys| keys[:number]}
     end
   end
   numbers.sort
end


def player_stats(player)
  stats={}
  game_hash.values.each do
    |keys| keys[:players].include?(players) ? stats = keys[:players][player] : nil
  end
  stats
end


def big_shoe_rebounds
  shoe = 0
  rebounds = 0
  game_hash.values.each do |keys|
    keys[:players].values.each do |stats|
      if stats[:shoe] > shoe
        shoe = stats[:shoe]
        rebounds = stats[:rebounds]
      end
    end
  end
  rebounds
end

def most_points_scored
  points = 0
  scored_most = ""
  game_hash.values.each do |keys|
    keys[:players].each do |player,stats|
      if stats[:points] > points
        points = stats[:points]
        scored_most = player
      end
    end
  end
  scored_most
end

def winning_team
  score_board = {}
  game_hash.values.each do |keys|
     points = 0
     keys[:players].values.each do |stats|
       points += stats[:points]
     end
     score_board[keys[:team_name]]= points
   end
   score_board.values[0] > score_board.values[1] ? score_board.keys[0] : score_board.keys[1]
end

def player_with_longest_name
 longest = ""
  game_hash.values.each do |keys|
    keys[:players].keys.each do |name|
      if name.length > longest.length
        longest = name
      end
    end
  end
  longest
end

def long_name_steals_a_ton?
  steals = {"" => 0}
  game_hash.values.each do |keys|
     keys[:players].each do |name,stats|
       if stats[:steals] > steals.values[0]
         steals = {name => stats[:steals]}
       end
     end
   end
   player_with_longest_name == steals.keys[0]
end


#binding.pry