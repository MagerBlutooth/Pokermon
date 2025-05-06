local all_cards_enhanced = function(enhancement)
end

local nuzlocke = {
    object_type = "Challenge",
    key = "nuzlocke",
    rules = {
        custom = {
            {id = 'no_shop_jokers'},
			{id = 'all_eternal'},
            {id = 'poke_add_joker_slots'},
            {id = 'poke_nuzlocke'}
        },
        modifiers = {
            {id = 'joker_slots', value = 1},
        }
    },
    restrictions = {
        banned_cards = {
            {id = 'c_judgement'},
            {id = 'c_wraith'},
            {id = 'c_soul'},
            {id = 'c_poke_pokeball'},
            {id = 'c_poke_greatball'},
            {id = 'c_poke_ultraball'},
            {id = 'c_poke_masterball'},
            {id = 'v_antimatter'},
            {id = 'p_buffoon_normal_1', ids = {
                'p_buffoon_normal_1','p_buffoon_normal_2','p_buffoon_jumbo_1','p_buffoon_mega_1',
            }},
            {id = 'j_gros_michel'},
            {id = 'j_ice_cream'},
            {id = 'j_cavendish'},
            {id = 'j_luchador'},
            {id = 'j_turtle_bean'},
            {id = 'j_diet_cola'},
            {id = 'j_popcorn'},
            {id = 'j_ramen'},
            {id = 'j_selzer'},
            {id = 'j_mr_bones'},
            {id = 'j_invisible'},
            {id = 'j_poke_gastly'},
            {id = 'j_poke_haunter'},
            {id = 'j_poke_gengar'},
            {id = 'j_poke_koffing'},
            {id = 'j_poke_weezing'},
            {id = 'j_poke_ditto'},
            {id = 'j_poke_mewtwo'},
            {id = 'j_poke_scyther'},
            {id = 'j_poke_scizor'},
            {id = 'j_poke_jelly_donut'},
        },
        banned_tags = {
            {id = 'tag_rare'},
            {id = 'tag_uncommon'},
            {id = 'tag_holo'},
            {id = 'tag_polychrome'},
            {id = 'tag_negative'},
            {id = 'tag_foil'},
            {id = 'tag_buffoon'},
            {id = 'tag_top_up'},
            {id = 'tag_poke_shiny_tag'},
            {id = 'tag_poke_stage_one_tag'},
            {id = 'tag_poke_safari_tag'},
        },
        banned_other = {
            {id = 'bl_final_leaf', type = 'blind'}
        },
        deck = {
            type = 'Challenge Deck'
        },
    }
}

-- add joker slots when ante increases with Nuzlocke
-- todo: insert this in a better spot for mod compat
local ea = ease_ante
function ease_ante(m)
    ea(m)
    if m > 0 then
        if G.GAME.modifiers.poke_add_joker_slots then
            G.GAME.poke_slots_added = G.GAME.poke_slots_added or 0
            G.GAME.poke_slots_added = G.GAME.poke_slots_added + 1
            if G.GAME.poke_slots_added <= 5 then
                G.jokers.config.card_limit = G.jokers.config.card_limit + 1
            end
        end
        if G.GAME.modifiers.poke_nuzlocke then
            G.GAME.first_shop_buffoon = false
        end
    end
end

local gp = get_pack
function get_pack(_key, _type)
    if G.GAME.modifiers.poke_nuzlocke and not G.GAME.first_shop_buffoon then
        G.GAME.first_shop_buffoon = true
        return G.P_CENTERS['p_buffoon_normal_'..(math.random(1, 2))]
    end
    return gp(_key, _type)
end

local goodasgold = {
    object_type = "Challenge",
    key = "goodasgold",
    rules = {
        modifiers = {
            {id = 'hand_size', value = 6},
            {id = 'dollars', value = 6}
        }
    },
    jokers = {
      {id = "j_poke_gholdengo", eternal = true},
    },
    restrictions = {
        banned_cards = {
            {id = 'j_poke_goldeen'},
            {id = 'j_poke_seaking'},
        },
        banned_tags = {
        },
        banned_other = {
        },
    },
    deck = {
      type = 'Challenge Deck',
      enhancement = 'm_gold',
    },
}

local parenthood = {
    object_type = "Challenge",
    key = "parenthood",
    name = "Parenthood",
    rules = {
        custom = {
            {id = 'no_shop_jokers'},
            {id = 'no_interest'}
        },
        modifiers = {
            {id = 'joker_slots', value = 2},
        }
    },
    jokers = {
      {id = 'j_poke_mystery_egg'},
      {id = 'j_poke_mystery_egg'},
    },
    consumeables = {
    },
    vouchers = {
    },
    deck = {
        type = 'Challenge Deck'
    },
    restrictions = {
        banned_cards = {
            {id = 'c_judgement'},
            {id = 'c_poke_pokeball'},
            {id = 'c_poke_greatball'},
            {id = 'c_poke_ultraball'},
            {id = 'c_poke_masterball'},
            {id = 'c_wraith'},
            {id = 'c_soul'},
            {id = 'v_blank'},
            {id = 'v_antimatter'},
            {id = 'p_buffoon_normal_1', ids = {
                'p_buffoon_normal_1','p_buffoon_normal_2','p_buffoon_jumbo_1','p_buffoon_mega_1',
            }},
        },
        banned_tags = {
            {id = 'tag_rare'},
            {id = 'tag_uncommon'},
            {id = 'tag_holo'},
            {id = 'tag_polychrome'},
            {id = 'tag_negative'},
            {id = 'tag_foil'},
            {id = 'tag_buffoon'},
            {id = 'tag_top_up'},
            {id = 'tag_poke_shiny_tag'},
            {id = 'tag_poke_stage_one_tag'},
            {id = 'tag_poke_safari_tag'}
        },
        banned_other = {
            {id = 'bl_final_heart', type = 'blind'},
            {id = 'bl_final_leaf', type = 'blind'}
        }
    }
}

local littlecup = {
    object_type = "Challenge",
    key = "littlecup",
    rules = {
        custom = {
          {id = 'no_reward_specific', value = 'Small'},
          {id = 'no_reward_specific', value = 'Big'},
        },
        modifiers = {
            {id = 'joker_slots', value = 3},
        }
    },
    jokers = {
      {id = "j_poke_everstone", eternal = true, edition = 'negative'},
    },
    restrictions = {
        banned_cards = {
        },
        banned_tags = {
        },
        banned_other = {
        },
    },
    deck = {
      type = 'Challenge Deck',
    },
}

local hammertime = {
    object_type = "Challenge",
    key = "hammertime",
    rules = {
        modifiers = {
            {id = 'hands', value = 2},
            {id = 'discards', value = 1},
        }
    },
    jokers = {
      {id = "j_poke_tinkaton", eternal = true},
    },
    restrictions = {
        banned_cards = {
        },
        banned_tags = {
        },
        banned_other = {
        },
    },
    deck = {
      cards = {{s='D',r='2',},{s='D',r='3',},{s='D',r='4',},{s='D',r='5',},{s='D',r='A'},
                {s='H',r='2',},{s='H',r='3',},{s='H',r='4',},{s='H',r='5',},{s='H',r='A'},
                {s='C',r='2',},{s='C',r='3',},{s='C',r='4',},{s='C',r='5',},{s='C',r='A'},
                {s='S',r='2',},{s='S',r='3',},{s='S',r='4',},{s='S',r='5',},{s='S',r='A',e='m_steel'},
        },
      type = 'Challenge Deck',
    },
}

local bunnelby_test = {
    object_type = "Challenge",
    key = "bunnelby_test",
    rules = {
        modifiers = {
            {id = 'joker_slots', value = 5},
			{id = 'discards', value = 2},
        }
    },
    jokers = {
      {id = "j_poke_bunnelby", eternal = true},
    },
    restrictions = {
        banned_cards = {
        },
        banned_tags = {
        },
        banned_other = {
        },
    },
    deck = {
      type = 'Challenge Deck',
    },
}

local wailmer_test = {
    object_type = "Challenge",
    key = "wailmer_test",
    rules = {
        modifiers = {
            {id = 'joker_slots', value = 5},
        }
    },
    jokers = {
      {id = "j_poke_wailmer", eternal = true},
    },
    restrictions = {
        banned_cards = {
        },
        banned_tags = {
        },
        banned_other = {
        },
    },
    deck = {
      type = 'Challenge Deck',
    },
}

local kecleon_test = {
    object_type = "Challenge",
    key = "kecleon_test",
    rules = {
        modifiers = {
            {id = 'joker_slots', value = 5},
			{id = 'dollars', value = 100}
        }
    },
    jokers = {
      {id = "j_poke_kecleon", eternal = true},
    },
	consumeables = {
		{id = "c_poke_colorless_energy"},
		{id = "c_poke_colorless_energy"}
	},
    restrictions = {
        banned_cards = {
        },
        banned_tags = {
        },
        banned_other = {
        },
    },
    deck = {
      type = 'Challenge Deck',
    },
}

local wimpod_test = {
    object_type = "Challenge",
    key = "wimpod_test",
    rules = {
        modifiers = {
            {id = 'joker_slots', value = 5},
        }
    },
    jokers = {
      {id = "j_poke_wimpod", eternal = false},
    },
    restrictions = {
        banned_cards = {
        },
        banned_tags = {
        },
        banned_other = {
        },
    },
    deck = {
      type = 'Challenge Deck',
    },
}

local sawk_throh = {
    object_type = "Challenge",
    key = "sawk_throh",
    rules = {
        modifiers = {
            {id = 'joker_slots', value = 3},
			{id = 'discards', value = 2}
        }
    },
    jokers = {
      {id = "j_poke_sawk", eternal = true},
	  {id = "j_poke_psyduck", eternal = true},
	  {id = "j_poke_throh", eternal = true},
    },
	consumeables = {
		{id = 'c_poke_fighting_energy'},
		{id = 'c_poke_fighting_energy'},
	},
    restrictions = {
        banned_cards = {
        },
        banned_tags = {
		{id = 'tag_negative'},
        },
        banned_other = {
        },
    },
    deck = {
      type = 'Challenge Deck',
    },
}

local teddy_bear = {
    object_type = "Challenge",
    key = "teddy_bear",
    rules = {
        modifiers = {
            {id = 'joker_slots', value = 5},
			{id = 'discards', value = 2},
        }
    },
    jokers = {
      {id = "j_poke_teddiursa", eternal = true},
    },
	consumeables = {
		{id = 'c_moon'},
	},
    restrictions = {
        banned_cards = {
        },
        banned_tags = {
        },
        banned_other = {
        },
    },
    deck = {
      type = 'Challenge Deck',
    },
}

local furfrou = {
    object_type = "Challenge",
    key = "furfrou",
    rules = {
        modifiers = {
            {id = 'joker_slots', value = 5},
			{id = 'discards', value = 2},
        }
    },
    jokers = {
      {id = "j_poke_furfrou", eternal = true},
    },
	consumeables = {
		{id = "c_poke_colorless_energy"},
		{id = "c_poke_colorless_energy"}
	},
    restrictions = {
        banned_cards = {
        },
        banned_tags = {
        },
        banned_other = {
        },
    },
    deck = {
      type = 'Challenge Deck',
    },
}

local checkmate = {
    object_type = "Challenge",
    key = "checkmate",
    rules = {
        modifiers = {
            {id = 'joker_slots', value = 5},
			{id = 'discards', value = 2},
        }
    },
    jokers = {
      {id = "j_poke_bisharp", eternal = true},
    },
	consumeables = {
	},
    restrictions = {
        banned_cards = {
        },
        banned_tags = {
        },
        banned_other = {
        },
    },
    deck = {
      type = 'Challenge Deck',
    },
}

local ruin = {
    object_type = "Challenge",
    key = "ruin",
    rules = {
        modifiers = {
            {id = 'joker_slots', value = 5},
			{id = 'discards', value = 2},
        }
    },
    jokers = {
      {id = "j_poke_chi_yu", eternal = true},
	  {id = "j_poke_ting_lu", eternal = true},
	  {id = "j_poke_wo_chien", eternal = true},
	  {id = "j_poke_chien_pao", eternal = true},
    },
	consumeables = {
	},
    restrictions = {
        banned_cards = {
        },
        banned_tags = {
        },
        banned_other = {
        },
    },
    deck = {
      type = 'Challenge Deck',
    },
}

local no_retreat = {
    object_type = "Challenge",
    key = "no_retreat",
    rules = {
        modifiers = {
            {id = 'joker_slots', value = 5},
			{id = 'discards', value = 2},
        }
    },
    jokers = {
      {id = "j_poke_falinks", eternal = true},
    },
	consumeables = {
	},
    restrictions = {
        banned_cards = {
        },
        banned_tags = {
        },
        banned_other = {
        },
    },
    deck = {
      type = 'Challenge Deck',
    },
}

local speed = {
    object_type = "Challenge",
    key = "speed",
    rules = {
        modifiers = {
            {id = 'joker_slots', value = 5},
			{id = 'discards', value = 2},
        }
    },
    jokers = {
      {id = "j_poke_karrablast", eternal = true},
    },
	consumeables = {
		{id = 'c_poke_linkcable'}
	},
    restrictions = {
        banned_cards = {
        },
        banned_tags = {
        },
        banned_other = {
        },
    },
    deck = {
      type = 'Challenge Deck',
    },
}

local rose = {
    object_type = "Challenge",
    key = "rose",
    rules = {
        modifiers = {
            {id = 'joker_slots', value = 5},
			{id = 'discards', value = 2},
        }
    },
    jokers = {
	  {id = "j_poke_shelmet", eternal = false},
      {id = "j_poke_budew", eternal = true},
    },
    restrictions = {
        banned_cards = {
        },
        banned_tags = {
        },
        banned_other = {
        },
    },
    deck = {
      type = 'Challenge Deck',
    },
}

local starter = {
    object_type = "Challenge",
    key = "starter",
    rules = {
        modifiers = {
            {id = 'joker_slots', value = 5},
			{id = 'discards', value = 2},
        }
    },
    jokers = {
	  {id = "j_poke_turtwig", eternal = false},
    },
    restrictions = {
        banned_cards = {
        },
        banned_tags = {
        },
        banned_other = {
        },
    },
    deck = {
      type = 'Challenge Deck',
    },
}
local drill = {
    object_type = "Challenge",
    key = "drill",
    rules = {
        modifiers = {
            {id = 'joker_slots', value = 5},
			{id = 'discards', value = 2},
        }
    },
    jokers = {
	  {id = "j_poke_drilbur", eternal = false},
    },
    restrictions = {
        banned_cards = {
        },
        banned_tags = {
        },
        banned_other = {
        },
    },
    deck = {
      type = 'Challenge Deck',
    },
}

local deer = {
    object_type = "Challenge",
    key = "deer",
    rules = {
        modifiers = {
            {id = 'joker_slots', value = 5},
			{id = 'discards', value = 2},
        }
    },
    jokers = {
	  {id = "j_poke_deerling", eternal = false},
    },
    restrictions = {
        banned_cards = {
        },
        banned_tags = {
        },
        banned_other = {
        },
    },
    deck = {
      type = 'Challenge Deck',
    },
}

return {name = "Challenges", 
        list = {nuzlocke, goodasgold, parenthood, littlecup, hammertime, bunnelby_test, wailmer_test, kecleon_test, wimpod_test, sawk_throh, teddy_bear, furfrou, ruin, no_retreat, speed, rose, drill, deer}
}