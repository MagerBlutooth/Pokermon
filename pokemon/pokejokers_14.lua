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
-- Luxio 404
-- Luxray 405
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
        list = {budew, roserade, buizel, floatzel},
}