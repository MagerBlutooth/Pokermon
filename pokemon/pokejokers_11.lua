-- Delcatty 301
-- Sableye 302
-- Mawile 303
-- Aron 304
local aron = {
  name = "aron",
  pos = { x = 2, y = 5 },
  config = { extra = { Xmult = 1, Xmult_mod = .25, eaten = 0 }, evo_rqmt = 2 },
  rarity = 2,
  cost = 6,
  stage = "Basic",
  atlas = "Pokedex3",
  ptype = "Metal",
  blueprint_compat = true,
  enhancement_gate = 'm_steel',
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    return { vars = { center.ability.extra.Xmult, center.ability.extra.Xmult_mod, center.ability.extra.eaten } }
  end,
  calculate = function(self, card, context)
    if context.cardarea == G.jokers and context.before and not context.blueprint then
      for k, v in ipairs(context.scoring_hand) do
        if v.config.center == G.P_CENTERS.m_steel and not v.debuff then
          card.ability.extra.eaten = card.ability.extra.eaten + 1
          card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_mod
          v.aron_target = true
          G.E_MANAGER:add_event(Event({
            func = function()
              v:juice_up()
              return true
            end
          }))
        end
      end
    elseif context.cardarea == G.jokers and context.scoring_hand and context.joker_main then
      return {
        message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult } },
        colour = G.C.XMULT,
        Xmult_mod = card.ability.extra.Xmult
      }
    elseif context.destroying_card then
      return not context.blueprint and context.destroying_card.config.center == G.P_CENTERS.m_steel and context.destroying_card.aron_target
    end
    return scaling_evo(self, card, context, "j_poke_lairon", card.ability.extra.Xmult, self.config.evo_rqmt)
  end
}
-- Lairon 305
local lairon = {
  name = "lairon",
  pos = { x = 3, y = 5 },
  config = { extra = { Xmult = 1, Xmult_mod = .4, eaten = 0 }, evo_rqmt = 4 },
  rarity = 3,
  cost = 8,
  stage = "One",
  atlas = "Pokedex3",
  ptype = "Metal",
  blueprint_compat = true,
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    return { vars = { center.ability.extra.Xmult, center.ability.extra.Xmult_mod, center.ability.extra.eaten } }
  end,
  calculate = function(self, card, context)
    if context.cardarea == G.jokers and context.before and not context.blueprint then
      for k, v in ipairs(context.scoring_hand) do
        if (v.config.center == G.P_CENTERS.m_steel or v.config.center == G.P_CENTERS.m_stone) and not v.debuff then
          card.ability.extra.eaten = card.ability.extra.eaten + 1
          card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_mod
          v.lairon_target = true
          G.E_MANAGER:add_event(Event({
            func = function()
              v:juice_up()
              return true
            end
          }))
        end
      end
    elseif context.cardarea == G.jokers and context.scoring_hand and context.joker_main then
      return {
        message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult } },
        colour = G.C.XMULT,
        Xmult_mod = card.ability.extra.Xmult
      }
    elseif context.destroying_card then
      return not context.blueprint and (context.destroying_card.config.center == G.P_CENTERS.m_steel or context.destroying_card.config.center == G.P_CENTERS.m_stone) 
             and context.destroying_card.lairon_target
    end
    return scaling_evo(self, card, context, "j_poke_aggron", card.ability.extra.Xmult, self.config.evo_rqmt)
  end
}
-- Aggron 306
local aggron = {
  name = "aggron",
  pos = { x = 4, y = 5 },
  config = { extra = { Xmult = 1, Xmult_mod = .4, eaten = 0 } },
  rarity = "poke_safari",
  cost = 12,
  stage = "Two",
  atlas = "Pokedex3",
  ptype = "Metal",
  blueprint_compat = true,
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    return { vars = { center.ability.extra.Xmult, center.ability.extra.Xmult_mod, center.ability.extra.eaten } }
  end,
  calculate = function(self, card, context)
    if context.cardarea == G.jokers and context.before and not context.blueprint then
      for k, v in ipairs(context.scoring_hand) do
        if (v.config.center == G.P_CENTERS.m_steel or v.config.center == G.P_CENTERS.m_stone or v.config.center == G.P_CENTERS.m_gold) and not v.debuff then
          card.ability.extra.eaten = card.ability.extra.eaten + 1
          card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_mod
          v.aggron_target = true
          G.E_MANAGER:add_event(Event({
            func = function()
              v:juice_up()
              return true
            end
          }))
        end
      end
    elseif context.cardarea == G.jokers and context.scoring_hand and context.joker_main then
      return {
        message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult } },
        colour = G.C.XMULT,
        Xmult_mod = card.ability.extra.Xmult
      }
    elseif context.destroying_card then
      local eat = context.destroying_card.config.center == G.P_CENTERS.m_steel or context.destroying_card.config.center == G.P_CENTERS.m_stone or
                  context.destroying_card.config.center == G.P_CENTERS.m_gold
      return not context.blueprint and eat and context.destroying_card.aggron_target
    end
  end
}
-- Meditite 307
-- Medicham 308
-- Electrike 309
-- Manectric 310
-- Plusle 311
-- Minun 312
-- Volbeat 313
-- Illumise 314
-- Roselia 315
local roselia = {
  name = "roselia",
  pos = {x = 3, y = 6},
  config = {extra = {mult = 6}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    return {vars = {center.ability.extra.mult}}
  end,
  rarity = 2,
  cost = 6,
  stage = "One",
  ptype = "Grass",
  atlas = "Pokedex3",
  item_req = "shinystone",
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
					elseif context.scoring_hand[i]:is_suit('Clubs', true) and suits["Clubs"] == 0  then suits["Clubs"] = suits["Clubs"] + 1 
				end
			end
		end
		for i = 1, #context.scoring_hand do
				if context.scoring_hand[i].ability.name == 'Wild Card' then
					if context.scoring_hand[i]:is_suit('Hearts') and suits["Hearts"] == 0 then suits["Hearts"] = suits["Hearts"] + 1
						elseif context.scoring_hand[i]:is_suit('Diamonds') and suits["Diamonds"] == 0  then suits["Diamonds"] = suits["Diamonds"] + 1
						elseif context.scoring_hand[i]:is_suit('Spades') and suits["Spades"] == 0  then suits["Spades"] = suits["Spades"] + 1
						elseif context.scoring_hand[i]:is_suit('Clubs') and suits["Clubs"] == 0  then suits["Clubs"] = suits["Clubs"] + 1 
					end
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
          message = localize{type = 'variable', key = 'a_mult', vars = {card.ability.extra.mult*unique_suits}}, 
          colour = G.C.MULT,
          mult_mod = card.ability.extra.mult*unique_suits
        }
	end
    return item_evo(self, card, context, "j_poke_roserade")
  end,
}
-- Gulpin 316
-- Swalot 317
-- Carvanha 318
-- Sharpedo 319
-- Wailmer 320
local wailmer = {
  name = "wailmer",
  pos = { x = 8, y = 6 },
  config = { extra = { mult = 3, hands_played = 0}, evo_rqmt = 15},
  rarity = 2,
  cost = 6,
  stage = "Basic",
  atlas = "Pokedex3",
  ptype = "Water",
  blueprint_compat = true,
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
	info_queue[#info_queue+1] = {set = 'Other', key = 'tier'}
	local hands_left = math.max(0, self.config.evo_rqmt - center.ability.extra.hands_played)
	local tier = get_poker_hand_tier(get_largest_poker_hand_name())
    return { vars = { center.ability.extra.mult*tier, hands_left, center.ability.extra.mult, get_largest_poker_hand_name()} }
  end,
  calculate = function(self, card, context)
    if context.before and not context.blueprint then
		if get_poker_hand_tier(context.scoring_name) == get_poker_hand_tier(get_largest_poker_hand_name()) then
			if G.GAME.hands[context.scoring_name].played == 1 and get_largest_poker_hand_name() ~= 'High Card' then --If the largest hand has only been played once, the largest hand just increased (unless High Card) 
				card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_upgrade_ex')})
			end	
		end
	end
    if context.cardarea == G.jokers and context.scoring_hand then
      local tier = get_poker_hand_tier(get_largest_poker_hand_name())
		if context.joker_main and get_poker_hand_tier(context.scoring_name) == tier then 
			card.ability.extra.hands_played = card.ability.extra.hands_played + 1
			  return {
				message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult*tier } },
				colour = G.C.MULT,
				mult_mod = card.ability.extra.mult*tier
			  }
		end
    end
    return scaling_evo(self, card, context, "j_poke_wailord", card.ability.extra.hands_played, self.config.evo_rqmt)
  end
}
-- Wailord 321
local wailord = {
  name = "wailord",
  pos = { x = 9, y = 6 },
  config = { extra = { mult = 4, Xmult = 0.2}},
  rarity = "poke_safari",
  cost = 6,
  stage = "Basic",
  atlas = "Pokedex3",
  ptype = "Water",
  blueprint_compat = true,
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
	info_queue[#info_queue+1] = {set = 'Other', key = 'tier'}
	local tier = get_poker_hand_tier(get_largest_poker_hand_name())
    return { vars = { tier*center.ability.extra.mult, 1+center.ability.extra.Xmult*tier, center.ability.extra.mult, center.ability.extra.Xmult, get_largest_poker_hand_name()} }
  end,
  calculate = function(self, card, context)
    if context.before then
		if get_poker_hand_tier(context.scoring_name) == get_poker_hand_tier(get_largest_poker_hand_name()) then
			if G.GAME.hands[context.scoring_name].played == 1 and get_largest_poker_hand_name() ~= 'High Card'  then --If the largest hand has only been played once, the largest hand just increased (unless High Card) 
				card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_upgrade_ex')})
			end	
		end
	end
	if context.cardarea == G.jokers and context.scoring_hand then
	local tier = get_poker_hand_tier(get_largest_poker_hand_name())
		if context.joker_main and get_poker_hand_tier(context.scoring_name) == tier then
			  return {
				message = localize("poke_wailmer_ex"), 
				colour = G.C.XMULT,
				mult_mod = card.ability.extra.mult*tier,
				Xmult_mod = 1+card.ability.extra.Xmult*tier
			  }
		 end
    end
  end
}
-- Numel 322
-- Camerupt 323
-- Torkoal 324
-- Spoink 325
-- Grumpig 326
-- Spinda 327
-- Trapinch 328
-- Vibrava 329
-- Flygon 330
return {
  name = "Pokemon Jokers 301-330",
  list = {aron, lairon, aggron, roselia, wailmer, wailord},
}
