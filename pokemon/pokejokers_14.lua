-- Monferno 391
-- Infernape 392
-- Piplup 393
-- Prinplup 394
-- Empoleon 395
-- Starly 396
-- Staravia 397
-- Staraptor 398
-- Bidoof 399
-- Bibarel 400
-- Kricketot 401
-- Kricketune 402
-- Shinx 403
-- Unaccounted bug occurs with Shinx and its evolutions where Shinx will not set the hand_score value properly. Possibly an issue with the timing due to using variable-based timing instead of 
-- a standard context. Seems to happen when more Jokers are present. Added a 1 sec. time delay to each evo stage as a potential fix.
local shinx={
  name = "shinx", 
  pos = {x = 2, y = 1}, 
  config = {extra = {money = 2, money_earned = 0, high_score = 0, hand_count = 0, current_hand_score = 0, score_accumulation = 0, spawn = true}, evo_rqmt = 20},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
		return {vars = {center.ability.extra.money, center.ability.extra.high_score, self.config.evo_rqmt - center.ability.extra.money_earned}}
  end,
  rarity = 1, 
  cost = 4, 
  stage = "Basic", 
  atlas = "Pokedex4",
  ptype = "Lightning",
  eternal_compat = true,
  perishable_compat = true,
  blueprint_compat = true,
  calculate = function(self, card, context)
  
	if context.setting_blind or card.ability.extra.spawn then
		card.ability.extra.hand_count = G.GAME.current_round.hands_played
		card.ability.extra.spawn = false
	end
  
	  if card.ability.extra.hand_count ~= G.GAME.current_round.hands_played then
		  if card.ability.extra.hand_count < G.GAME.current_round.hands_played then
			  delay(1.0)
			  card.ability.extra.hand_count = G.GAME.current_round.hands_played
			  card.ability.extra.current_hand_score = G.GAME.chips - card.ability.extra.score_accumulation
			  card.ability.extra.score_accumulation = card.ability.extra.score_accumulation + card.ability.extra.current_hand_score 
			  card_eval_status_text(card, 'extra', nil, nil, nil, {message = "New: " .. card.ability.extra.current_hand_score})
				if card.ability.extra.current_hand_score > card.ability.extra.high_score then
					card.ability.extra.high_score = card.ability.extra.current_hand_score
					local earned = ease_poke_dollars(card, 'shinx', card.ability.extra.money, true)
					card.ability.extra.money_earned = card.ability.extra.money_earned + earned
					return {
						--message = localize{type='variable',key='a_mult',vars={"New Score: " .. card.ability.extra.current_hand_score},
						dollars = earned,
						card = card,
					}
				end
		  end
			card.ability.extra.hand_count = G.GAME.current_round.hands_played
		end
		if context.end_of_round then
			card.ability.extra.current_hand_score = 0
			card.ability.extra.score_accumulation = 0
		end

		return scaling_evo(self, card, context, "j_poke_luxio", card.ability.extra.money_earned, self.config.evo_rqmt)
  end,
}
-- Luxio 404
local luxio={
  name = "luxio", 
  pos = {x = 3, y = 1}, 
  config = {extra = {money = 4, mult = 1, dollar_per_mult = 5, money_earned = 0, high_score = 2000, hand_count = 0, current_hand_score = 0, score_accumulation = 0, spawn = true}, evo_rqmt = 40},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    local abbr = center.ability.extra
	return {vars = {abbr.money, abbr.high_score, self.config.evo_rqmt - abbr.money_earned, abbr.mult, abbr.dollar_per_mult, math.floor(G.GAME.dollars/abbr.dollar_per_mult)*abbr.mult}}
  end,
  rarity = "poke_safari", 
  cost = 8, 
  stage = "Basic", 
  atlas = "Pokedex4",
  ptype = "Lightning",
  eternal_compat = true,
  perishable_compat = true,
  blueprint_compat = true,
  calculate = function(self, card, context)
  
	if context.setting_blind or card.ability.extra.spawn then
		card.ability.extra.hand_count = G.GAME.current_round.hands_played
		card.ability.extra.spawn = false
	end
	
	if context.joker_main then
		return {
			message = localize{type='variable',key='a_mult',vars={math.floor(G.GAME.dollars/card.ability.extra.dollar_per_mult)*card.ability.extra.mult}},
			mult_mod = math.floor(G.GAME.dollars/card.ability.extra.dollar_per_mult)*card.ability.extra.mult, 
			colour = G.C.MULT
        }
      end
  
	   if card.ability.extra.hand_count ~= G.GAME.current_round.hands_played then
		  if card.ability.extra.hand_count < G.GAME.current_round.hands_played then
				  delay(1.0)
				  card.ability.extra.hand_count = G.GAME.current_round.hands_played
				  card.ability.extra.current_hand_score = G.GAME.chips - card.ability.extra.score_accumulation
				  card.ability.extra.score_accumulation = card.ability.extra.score_accumulation + card.ability.extra.current_hand_score 
				  card_eval_status_text(card, 'extra', nil, nil, nil, {message = "New: " .. card.ability.extra.current_hand_score})
					if card.ability.extra.current_hand_score > card.ability.extra.high_score then
						card.ability.extra.high_score = card.ability.extra.current_hand_score
						local earned = ease_poke_dollars(card, 'luxio', card.ability.extra.money, true)
						card.ability.extra.money_earned = card.ability.extra.money_earned + earned
						return {
							--message = localize{type='variable',key='a_mult',vars={"New Score: " card.ability.extra.current_hand_score},
							dollars = earned,
							card = card,
						}
					end
  			card.ability.extra.hand_count = G.GAME.current_round.hands_played
		end
				
			
			end
		if context.end_of_round then
			card.ability.extra.current_hand_score = 0
			card.ability.extra.score_accumulation = 0
		end
		
		return scaling_evo(self, card, context, "j_poke_luxray", card.ability.extra.money_earned, self.config.evo_rqmt)
		
  end,
}
-- Luxray 405
local luxray={
  name = "luxray", 
  pos = {x = 4, y = 1}, 
  config = {extra = {money = 6, Xmult = 0.1, dollar_per_Xmult = 10, money_earned = 0, high_score = 10000, hand_count = 0, current_hand_score = 0, score_accumulation = 0, spawn = true}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
	local abbr = center.ability.extra
		return {vars = {abbr.money, abbr.high_score, abbr.Xmult, abbr.dollar_per_Xmult, 1+ math.floor(G.GAME.dollars/abbr.dollar_per_Xmult)*abbr.Xmult}}
  end,
  rarity = "poke_safari", 
  cost = 12, 
  stage = "Basic", 
  atlas = "Pokedex4",
  ptype = "Lightning",
  eternal_compat = true,
  perishable_compat = true,
  blueprint_compat = true,
  calculate = function(self, card, context)
  
	if context.setting_blind or card.ability.extra.spawn then
		card.ability.extra.hand_count = G.GAME.current_round.hands_played
		card.ability.extra.spawn = false
	end
	
	if context.joker_main then
		return {
			message = localize{type='variable',key='a_xmult',vars={1 + math.floor(G.GAME.dollars/card.ability.extra.dollar_per_Xmult)*card.ability.extra.Xmult}},
			Xmult_mod = math.floor(G.GAME.dollars/card.ability.extra.dollar_per_Xmult)*card.ability.extra.Xmult, 
			colour = G.C.XMULT,
        }
      end
  
	  if card.ability.extra.hand_count ~= G.GAME.current_round.hands_played then
		  if card.ability.extra.hand_count < G.GAME.current_round.hands_played then
			delay(1.0)
			card.ability.extra.hand_count = G.GAME.current_round.hands_played
        	card.ability.extra.current_hand_score = G.GAME.chips - card.ability.extra.score_accumulation
				  card.ability.extra.score_accumulation = card.ability.extra.score_accumulation + card.ability.extra.current_hand_score 
				  card_eval_status_text(card, 'extra', nil, nil, nil, {message = "New: " .. card.ability.extra.current_hand_score})
					if card.ability.extra.current_hand_score > card.ability.extra.high_score then
						card.ability.extra.high_score = card.ability.extra.current_hand_score
						local earned = ease_poke_dollars(card, 'luxray', card.ability.extra.money, true)
						card.ability.extra.money_earned = card.ability.extra.money_earned + earned
						return {
							--message = localize{type='variable',key='a_mult',vars={"New Score: " card.ability.extra.current_hand_score},
							dollars = earned,
							card = card,
						}
					end
			end
			card.ability.extra.hand_count = G.GAME.current_round.hands_played
		end
		
		if context.end_of_round then
			card.ability.extra.current_hand_score = 0
			card.ability.extra.score_accumulation = 0
		end
  end,
}
-- Budew 406
local budew = {
  name = "budew",
  pos = {x = 5, y = 1},
  config = {extra = {Xmult_minus = 0.75, rounds = 2,}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    info_queue[#info_queue+1] = {set = 'Other', key = 'baby'}
	info_queue[#info_queue+1] = {key = 'e_negative_consumable', set = 'Edition', config = {extra = 1}}
    info_queue[#info_queue+1] = G.P_CENTERS.c_lovers
    return {vars = {center.ability.extra.Xmult_minus, center.ability.extra.rounds, }}
  end,
  rarity = 1,
  cost = 3,
  stage = "Baby",
  ptype = "Grass",
  atlas = "Pokedex4",
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    if context.cardarea == G.jokers and context.scoring_hand then
		if context.joker_main then
			faint_baby_poke(self, card, context) 
			return {
			  message = localize{type = 'variable', key = 'a_xmult', vars = {card.ability.extra.Xmult_minus}}, 
			  colour = G.C.XMULT,
			  Xmult_mod = card.ability.extra.Xmult_minus
			}
		end
    end
    if context.end_of_round and not context.individual and not context.repetition and not card.debuff then
      local _card = create_card('Tarot', G.consumeables, nil, nil, nil, nil, 'c_lovers')
      local edition = {negative = true}
      _card:set_edition(edition, true)
      _card:add_to_deck()
      G.consumeables:emplace(_card)
    end
    return level_evo(self, card, context, "j_poke_roselia")
  end,
}
-- Roserade 407
local roserade = {
  name = "roserade",
  pos = {x = 6, y = 1},
  config = {extra = {Xmult = 0.5}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    return {vars = {center.ability.extra.Xmult}}
  end,
  rarity = "poke_safari",
  cost = 9,
  stage = "Two",
  ptype = "Grass",
  atlas = "Pokedex4",
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    if context.cardarea == G.jokers and context.scoring_hand and context.joker_main then
      local unique_suits = 0
          local suits = {
        ['Hearts'] = 0,
        ['Diamonds'] = 0,
        ['Spades'] = 0,
        ['Clubs'] = 0
      }
      for i = 1, #context.scoring_hand do
        if context.scoring_hand[i].ability.name ~= 'Wild Card' then
          if context.scoring_hand[i]:is_suit('Hearts', true) and suits["Hearts"] == 0 then suits["Hearts"] = suits["Hearts"] + 1
          elseif context.scoring_hand[i]:is_suit('Diamonds', true) and suits["Diamonds"] == 0  then suits["Diamonds"] = suits["Diamonds"] + 1
          elseif context.scoring_hand[i]:is_suit('Spades', true) and suits["Spades"] == 0  then suits["Spades"] = suits["Spades"] + 1
          elseif context.scoring_hand[i]:is_suit('Clubs', true) and suits["Clubs"] == 0  then suits["Clubs"] = suits["Clubs"] + 1 end
        end
      end
      for i = 1, #context.scoring_hand do
          if context.scoring_hand[i].ability.name == 'Wild Card' then
            if context.scoring_hand[i]:is_suit('Hearts') and suits["Hearts"] == 0 then suits["Hearts"] = suits["Hearts"] + 1
            elseif context.scoring_hand[i]:is_suit('Diamonds') and suits["Diamonds"] == 0  then suits["Diamonds"] = suits["Diamonds"] + 1
            elseif context.scoring_hand[i]:is_suit('Spades') and suits["Spades"] == 0  then suits["Spades"] = suits["Spades"] + 1
            elseif context.scoring_hand[i]:is_suit('Clubs') and suits["Clubs"] == 0  then suits["Clubs"] = suits["Clubs"] + 1 end
            end
        end
          if suits["Hearts"] > 0 then
          unique_suits = unique_suits + 1
          end
          if suits["Diamonds"] > 0 then
          unique_suits = unique_suits + 1
          end
        if suits["Spades"] > 0 then
          unique_suits = unique_suits + 1
          end
        if suits["Clubs"] > 0 then
          unique_suits = unique_suits + 1
          end
      return {
            message = localize{type = 'variable', key = 'a_xmult', vars = {1 + (card.ability.extra.Xmult * unique_suits)}}, 
            colour = G.C.XMULT,
            Xmult_mod = 1 + (card.ability.extra.Xmult * unique_suits)
          }
    end
  end,
}
-- Cranidos 408
-- Rampardos 409
-- Shieldon 410
-- Bastiodon 411
-- Burmy 412
-- Wormadam 413
-- Mothim 414
-- Combee 415
-- Vespiquen 416
-- Pachirisu 417
-- Buizel 418
local buizel={
  name = "buizel", 
  pos = {x = 3, y = 2}, 
  config = {extra = {chips = 20, rounds = 4}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
		return {vars = {center.ability.extra.chips, center.ability.extra.rounds}}
  end,
  rarity = 1, 
  cost = 4, 
  stage = "Basic", 
  atlas = "Pokedex4",
  ptype = "Water",
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.cardarea == G.jokers and context.scoring_hand and context.full_hand then
      if context.joker_main then
        local chips = card.ability.extra.chips * math.abs(#context.scoring_hand - #context.full_hand)
        if chips > 0 then
          return {
              message = localize{type = 'variable', key = 'a_chips', vars = {chips}}, 
              colour = G.C.CHIPS,
              chip_mod = chips
            }
        end
      end
    end
    return level_evo(self, card, context, "j_poke_floatzel")
  end,
}
-- Floatzel 419
local floatzel={
  name = "floatzel", 
  pos = {x = 4, y = 2}, 
  config = {extra = {chips = 40}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
		return {vars = {center.ability.extra.chips}}
  end,
  rarity = 2, 
  cost = 6, 
  stage = "One", 
  atlas = "Pokedex4",
  ptype = "Water",
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.cardarea == G.jokers and context.scoring_hand and context.full_hand then
      if context.joker_main then
        local chips = card.ability.extra.chips * math.abs(#context.scoring_hand - #context.full_hand)
        if chips > 0 then
          return {
              message = localize{type = 'variable', key = 'a_chips', vars = {chips}}, 
              colour = G.C.CHIPS,
              chip_mod = chips
            }
        end
      end
    end
  end,
}
-- Cherubi 420
return {name = "Pokemon Jokers 391-420", 
        list = {shinx, luxio, luxray, budew, roserade, buizel, floatzel},
}