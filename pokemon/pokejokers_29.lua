-- Flapple 841
-- Appletun 842
-- Silicobra 843
-- Sandaconda 844
-- Cramorant 845
-- Arrokuda 846
-- Barraskewda 847
-- Toxel 848
-- Toxtricity 849
-- Sizzlipede 850
-- Centiskorch 851
-- Clobbopus 852
local clobbopus={
  name = "clobbopus", 
  pos = {x = 3, y = 3},
  config = {extra = {pairs_played = 0}, evo_rqmt = 15},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    return {vars = {self.config.evo_rqmt - center.ability.extra.pairs_played}}
  end,
  rarity = 1, 
  cost = 5, 
  stage = "Basic",
  ptype = "Fighting",
  atlas = "Pokedex8",
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
  
   if context.joker_main then
		if context.scoring_name == 'Pair' then
		card.ability.extra.pairs_played = card.ability.extra.pairs_played + 1
		
		--Get the first card played with a valid rank to avoid Stone and Debuffed cards if played as leftmost card
		local rank = 0
		for i = 1, #context.scoring_hand do
			if context.scoring_hand[i].config.center ~= G.P_CENTERS.m_stone and not context.scoring_hand[i].debuff then 
				if context.scoring_hand[i]:is_face() then
					rank = 10
				elseif context.scoring_hand[i]:get_id() == 14 then
					rank = 11
				else
					rank = context.scoring_hand[i].base.id
				end
				break
			end 
		end
		  return {
			message = localize{type = 'variable', key = 'a_mult', vars = {rank}}, 
			colour = G.C.MULT,
			mult_mod = rank
		  }
		 end
	end
	return scaling_evo(self, card, context, "j_poke_grapploct", card.ability.extra.pairs_played, self.config.evo_rqmt)
  end,
}

-- Grapploct 853
local grapploct={
  name = "grapploct", 
  pos = {x = 4, y = 3},
  config = {extra = {}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    return {vars = { }}
  end,
  rarity = 3, 
  cost = 9, 
  stage = "One",
  ptype = "Fighting",
  atlas = "Pokedex8",
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)

    if context.joker_main then
		if context.scoring_name == 'High Card' or context.scoring_name == 'Pair' or context.scoring_name =='Three of a Kind' or context.scoring_name =='Four of a Kind' or context.scoring_name =='Five of a Kind' or context.scoring_name == 'Flush Five' then
		--Get the first card played with a valid rank to avoid Stone and Debuffed cards if played as leftmost card
		local rank = 0
		local rank_times = 0
		for i = 1, #context.scoring_hand do
			if context.scoring_hand[i].config.center ~= G.P_CENTERS.m_stone and not context.scoring_hand[i].debuff and not SMODS.has_enhancement(context.scoring_hand[i], "m_poke_hazard") then
				if context.scoring_hand[i]:is_face() then
					rank = 10
				elseif context.scoring_hand[i]:get_id() == 14 then
					rank = 11
				else
					rank = context.scoring_hand[i].base.id 
				end
				rank_times = rank_times + 1
			elseif context.scoring_hand[i].debuff then
				rank_times = rank_times + 1
			end
		end
			return {
				message = localize{type = 'variable', key = 'a_mult', vars = {rank_times * rank}}, 
				colour = G.C.MULT,
				mult_mod = rank_times * rank
			}
		end
	end
end,

}
-- Sinistea 854
-- Polteageist 855
-- Hatenna 856
-- Hattrem 857
-- Hatterene 858
-- Impidimp 859
-- Morgrem 860
-- Grimmsnarl 861
-- Obstagoon 862
-- Perrserker 863
-- Cursola 864
-- Sirfetch'd 865
-- Mr. Rime 866
-- Runerigus 867
-- Milcery 868
-- Alcremie 869
-- Falinks 870


return {name = "Pokemon Jokers 841-870", 
        list = {clobbopus, grapploct},
}