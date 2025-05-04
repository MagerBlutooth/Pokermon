-- Cacnea 331
-- Cacturne 332
-- Swablu 333
-- Altaria 334
-- Zangoose 335
-- Seviper 336
-- Lunatone 337
-- Solrock 338
-- Barboach 339
-- Whiscash 340
-- Corphish 341
-- Crawdaunt 342
-- Baltoy 343
-- Claydol 344
-- Lileep 345
-- Cradily 346
-- Anorith 347
-- Armaldo 348
-- Feebas 349
local feebas={
  name = "feebas",
  pos = {x = 7, y = 9},
  config = {extra = {mult = 1}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    info_queue[#info_queue+1] = { set = 'Joker', key = 'j_splash', config={}}
    return {vars = {center.ability.extra.mult}}
  end,
  rarity = 3, 
  cost = 3, 
  item_req = "prismscale",
  stage = "Basic", 
  ptype = "Water",
  atlas = "Pokedex3",
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.cardarea == G.jokers and context.scoring_hand then
      if context.joker_main then
        return {
          message = localize{type = 'variable', key = 'a_mult', vars = {card.ability.extra.mult}}, 
          colour = G.C.MULT,
          mult_mod = card.ability.extra.mult
        }
      end
    end
    return item_evo(self, card, context, "j_poke_milotic")
  end
}
-- Milotic 350
local milotic={
  name = "milotic",
  pos = {x = 8, y = 9},
  config = {extra = {mult = 1,mult_mod = 1,retriggers = 1, active = false}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
  end,
  rarity = "poke_safari",
  cost = 8,
  stage = "One",
  ptype = "Water",
  atlas = "Pokedex3",
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    if context.cardarea == G.jokers and context.scoring_hand then
      if context.before and poke_same_suit(context.scoring_hand) then
        card.ability.extra.active = true
      end
      if context.after and card.ability.extra.active then
        card.ability.extra.active = false
      end
    end
    if context.repetition and not context.end_of_round and context.cardarea == G.play and card.ability.extra.active then
      return {
        message = localize('k_again_ex'),
        repetitions = card.ability.extra.retriggers,
        card = card
      }
    end
  end
}
-- Castform 351
-- Kecleon 352
-- Minor bug causes Kecleon to proc automatically the first time when you start with it.
-- Minor timing delay when certain effects give you a Joker, like using a Poke Ball in the store. Causes potential issue with timing if you move the Joker and sell it, causing the effect to trigger.
local kecleon={
  name = "kecleon",
  pos = {x = 3, y = 10},
  config = {extra = {mult_mod = 2, mult = 0, joker_tally = (G.jokers and #G.jokers or 0), latest_type = "Colorless"}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    return {vars = {center.ability.extra.mult_mod, center.ability.extra.mult}}
  end,
  rarity = 3,
  cost = 8,
  stage = "Basic",
  ptype = "Colorless",
  atlas = "Pokedex3",
  perishable_compat = true,
  blueprint_compat = false,
  eternal_compat = true,
  calculate = function(self, card, context)
    if context.cardarea == G.jokers and context.scoring_hand then
      if context.joker_main then
        return {
          message = localize{type = 'variable', key = 'a_mult', vars = {card.ability.extra.mult}}, 
          colour = G.C.MULT,
          mult_mod = card.ability.extra.mult
        }
      end
    end

	--Update Kecleon if a new Joker is obtained for any reason
	if #G.jokers.cards > card.ability.extra.joker_tally then
		local newest_joker = G.jokers.cards[#G.jokers.cards]
		if has_type(newest_joker) and not is_type(card, newest_joker.ability.extra.ptype) then
			apply_type_sticker(card, newest_joker.ability.extra.ptype)
			card.ability.extra.joker_tally = #G.jokers.cards
		end
	elseif #G.jokers.cards < card.ability.extra.joker_tally then
		card.ability.extra.joker_tally = #G.jokers.cards
	end
	  
	  
  -- --Increase Kecleon's mult if it changes type for any reason
  if not is_type(card, card.ability.extra.latest_type) then
	card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
	card.ability.extra.latest_type = get_type(card)
	card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('poke_kecleon_ex'), colour = G.C.FILTER})
	card:juice_up()
	--Set sprite depending on type
		if is_type(card, "Dark") then
		  card.children.center:set_sprite_pos({x = 0, y = 16})
		elseif is_type(card, "Dragon") then
		  card.children.center:set_sprite_pos({x = 1, y = 16})
		elseif is_type(card, "Earth") then
		  card.children.center:set_sprite_pos({x = 2, y = 16})
		elseif is_type(card, "Fairy") then
		  card.children.center:set_sprite_pos({x = 3, y = 16})
		elseif is_type(card, "Fighting") then
		  card.children.center:set_sprite_pos({x = 4, y = 16})
		elseif is_type(card, "Fire") then
		  card.children.center:set_sprite_pos({x = 5, y = 16})
		elseif is_type(card, "Grass") then
		  card.children.center:set_sprite_pos({x = 6, y = 16})
		elseif is_type(card, "Lightning") then
		  card.children.center:set_sprite_pos({x = 0, y = 17})
		elseif is_type(card, "Metal") then
		  card.children.center:set_sprite_pos({x = 1, y = 17})
		elseif is_type(card, "Psychic") then
		  card.children.center:set_sprite_pos({x = 2, y = 17})
		elseif is_type(card, "Water") then
		  card.children.center:set_sprite_pos({x = 3, y = 17})
		else
		  card.children.center:set_sprite_pos({x = 3, y = 10})
		end
	end
  end
}

-- Shuppet 353
-- Banette 354
-- Duskull 355
-- Dusclops 356
-- Tropius 357
-- Chimecho 358
-- Absol 359
-- Wynaut 360
local wynaut={
  name = "wynaut",
  pos = {x = 1, y = 11},
  config = {extra = {Xmult_minus = 0.75,rounds = 2,}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    info_queue[#info_queue+1] = {set = 'Other', key = 'baby'}
    info_queue[#info_queue+1] = {key = 'e_negative_consumable', set = 'Edition', config = {extra = 1}}
    info_queue[#info_queue+1] = G.P_CENTERS.c_fool
    return {vars = {center.ability.extra.Xmult_minus, center.ability.extra.rounds, }}
  end,
  rarity = 3,
  cost = 4,
  stage = "Baby",
  ptype = "Psychic",
  atlas = "Pokedex3",
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
      local _card = create_card('Tarot', G.consumeables, nil, nil, nil, nil, 'c_fool')
      local edition = {negative = true}
      _card:set_edition(edition, true)
      _card:add_to_deck()
      G.consumeables:emplace(_card)
    end
    return level_evo(self, card, context, "j_poke_wobbuffet")
  end,
}
return {name = "Pokemon Jokers 331-360", 
        list = {feebas, milotic, kecleon, wynaut},
}
