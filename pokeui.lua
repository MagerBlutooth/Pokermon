--Config UI
local restart_toggles_left = { 
                 {ref_value = "pokeballs", label = "poke_settings_pokeballs"},
                 {ref_value = "pokemon_altart", label = "poke_settings_pokemon_altart"},
                 {ref_value = "pokemon_aprilfools", label = "poke_settings_pokemon_aprilfools"},
                 {ref_value = "poke_enable_animations", label = "poke_settings_enable_animations"}
                }
                
local restart_toggles_right = { 
  {ref_value = "pokemon_splash", label = "poke_settings_pokemon_splash"}, 
  {ref_value = "pokemon_discovery", label = "poke_settings_pokemon_discovery", tooltip = {set = 'Other', key = 'discovery_tooltip'}},
  {ref_value = "pokemon_legacy", label = "poke_settings_pokemon_legacy"}
}

local no_restart_toggles = {{ref_value = "pokemon_only", label = "poke_settings_pokemon_only"}, {ref_value = "shiny_playing_cards", label = "poke_settings_shiny_playing_cards"},
                          {ref_value = "gen_one", label = "poke_settings_pokemon_gen_one"}, }
 
local energy_toggles = {
  {ref_value = "unlimited_energy", label = "poke_settings_unlimited_energy", tooltip = {set = 'Other', key = 'unlimited_energy_tooltip'}}, 
  {ref_value = "precise_energy", label = "poke_settings_pokemon_precise_energy", tooltip = {set = 'Other', key = 'precise_energy_tooltip'}},
}

local joker_pool_toggles = {
  {ref_value = "pokemon_only", label = "poke_settings_pokemon_only", tooltip = {set = 'Other', key = 'pokemononly_tooltip'}},
  {ref_value = "gen_one", label = "poke_settings_pokemon_gen_one", tooltip = {set = 'Other', key = 'gen1_tooltip'}},
  {ref_value = "gen_two", label = "poke_settings_pokemon_gen_two", tooltip = {set = 'Other', key = 'gen2_tooltip'}},
  {ref_value = "gen_three", label = "poke_settings_pokemon_gen_three", tooltip = {set = 'Other', key = 'gen3_tooltip'}},
  {ref_value = "gen_four", label = "poke_settings_pokemon_gen_four", tooltip = {set = 'Other', key = 'gen4_tooltip'}},
  {ref_value = "gen_five", label = "poke_settings_pokemon_gen_five", tooltip = {set = 'Other', key = 'gen5_tooltip'}},
  {ref_value = "gen_six", label = "poke_settings_pokemon_gen_six", tooltip = {set = 'Other', key = 'gen6_tooltip'}},
  {ref_value = "gen_seven", label = "poke_settings_pokemon_gen_seven", tooltip = {set = 'Other', key = 'gen7_tooltip'}},
  {ref_value = "gen_eight", label = "poke_settings_pokemon_gen_eight", tooltip = {set = 'Other', key = 'gen8_tooltip'}},
  {ref_value = "gen_nine", label = "poke_settings_pokemon_gen_nine", tooltip = {set = 'Other', key = 'gen9_tooltip'}},
}

local misc_no_restart_toggles = {
  {ref_value = "shiny_playing_cards", label = "poke_settings_shiny_playing_cards", tooltip = {set = 'Other', key = 'shinyplayingcard_tooltip'}}
}

local content_toggles = {
  {ref_value = "pokemon_legacy", label = "poke_settings_pokemon_legacy", tooltip = {set = 'Other', key = 'legacycontent_tooltip'}},
  {ref_value = "pokemon_aprilfools", label = "poke_settings_pokemon_aprilfools", tooltip = {set = 'Other', key = 'jokecontent_tooltip'}},
}

local visual_toggles = {
  {ref_value = "pokemon_splash", label = "poke_settings_pokemon_splash", tooltip = {set = 'Other', key = 'splashcard_tooltip'}},
  {ref_value = "pokemon_altart", label = "poke_settings_pokemon_altart", tooltip = {set = 'Other', key = 'altart_tooltip'}},
  {ref_value = "poke_enable_animations", label = "poke_settings_enable_animations", tooltip = {set = 'Other', key = 'animation_tooltip'}}
}

local misc_restart_toggles = {
  {ref_value = "pokeballs", label = "poke_settings_pokeballs", tooltip = {set = 'Other', key = 'allowpokeballs_tooltip'}},
  {ref_value = "pokemon_discovery", label = "poke_settings_pokemon_discovery", tooltip = {set = 'Other', key = 'discovery_tooltip'}},
}
 
local create_menu_toggles = function (parent, toggles)
  for k, v in ipairs(toggles) do
    parent.nodes[#parent.nodes + 1] = create_toggle({
          label = localize(v.label),
          ref_table = pokermon_config,
          ref_value = v.ref_value,
          callback = function(_set_toggle)
            NFS.write(mod_dir.."/config.lua", STR_PACK(pokermon_config))
          end,
    })
    if v.tooltip then
      parent.nodes[#parent.nodes].config.detailed_tooltip = v.tooltip
    end
  end
end

pokemonconfig = function()
  local restart_left_settings = {n = G.UIT.C, config = {align = "tl", padding = 0.05, scale = 0.75, colour = G.C.CLEAR,}, nodes = {}}
  create_menu_toggles(restart_left_settings, restart_toggles_left)

  local restart_right_settings = {n = G.UIT.C, config = {align = "tl", padding = 0.05, scale = 0.75, colour = G.C.CLEAR,}, nodes = {}}
  create_menu_toggles(restart_right_settings, restart_toggles_right)

  local no_restart_settings = {n = G.UIT.R, config = {align = "tm", padding = 0.05, scale = 0.75, colour = G.C.CLEAR,}, nodes = {}}
  create_menu_toggles(no_restart_settings, no_restart_toggles)
  
  local config_nodes =   
  {
    {
      n = G.UIT.R,
      config = {
        padding = 0.25,
        align = "cm"
      },
      nodes = {
        {
          n = G.UIT.T,
          config = {
            text = localize("poke_settings_header_norequired"),
            shadow = true,
            scale = 0.75 * 0.8,
            colour = HEX("ED533A")
          }
        }
      },
    },
    UIBox_button({
      minw = 3.85,
      colour = HEX("ED533A"),
      button = "pokermon_joker_pool",
      label = {"Joker Pool Options"}
    }),
    UIBox_button({
      minw = 3.85,
      colour = HEX("FF7ABF"),
      button = "pokermon_energy",
      label = {"Energy Options"}
    }),
    UIBox_button({
      minw = 3.85,
      colour = HEX("9AA4B7"),
      button = "pokermon_misc_no_restart",
      label = {"Misc Options"}
    }),
    {
      n = G.UIT.R,
      config = {
        padding = 0.25,
        align = "cm"
      },
      nodes = {
        {
          n = G.UIT.T,
          config = {
            text = localize("poke_settings_header_required"),
            shadow = true,
            scale = 0.75 * 0.8,
            colour = HEX("ED533A")
          }
        }
      },
    },
    UIBox_button({
      minw = 3.85,
      colour = HEX("38b8f8"),
      button = "pokermon_content",
      label = {"Content Options"}
    }),
    UIBox_button({
      minw = 3.85,
      colour = HEX("c135ff"),
      button = "pokermon_visual",
      label = {"Visual Options"}
    }),
    UIBox_button({
      minw = 3.85,
      colour = HEX("9AA4B7"),
      button = "pokermon_misc_restart",
      label = {"Misc Options"}
    }),
  }
  return config_nodes
end

SMODS.current_mod.config_tab = function()
    return {
      n = G.UIT.ROOT,
      config = {
        align = "cm",
        padding = 0.05,
        colour = G.C.CLEAR,
      },
      nodes = pokemonconfig()
    }
end

SMODS.current_mod.extra_tabs = function()
  local scale = 0.75
  return {
    label = localize("poke_credits_actualcredits"),
    tab_definition_function = function()
      return {
        n = G.UIT.ROOT,
        config = {
          align = "cm",
          padding = 0.05,
          colour = G.C.CLEAR,
        },
        nodes = {
          {
            n = G.UIT.R,
            config = {
              padding = 0,
              align = "cm"
            },
            nodes = {
              {
                n = G.UIT.T,
                config = {
                  text = localize("poke_credits_thanks"),
                  shadow = true,
                  scale = scale * 0.8,
                  colour = G.C.UI.TEXT_LIGHT
                }
              }
            }
          },
          {
            n = G.UIT.R,
            config = {
              padding = 0,
              align = "cm"
            },
            nodes = {
              {
                n = G.UIT.T,
                config = {
                  text = localize("poke_credits_lead"),
                  shadow = true,
                  scale = scale * 0.8,
                  colour = G.C.UI.TEXT_LIGHT
                }
              },
              {
                n = G.UIT.T,
                config = {
                  text = "InertSteak",
                  shadow = true,
                  scale = scale * 0.8,
                  colour = G.C.BLUE
                }
              }
            }
          },
          {
            n = G.UIT.R,
            config = {
              padding = 0,
              align = "cm"
            },
            nodes = {
              {
                n = G.UIT.T,
                config = {
                  text = localize("poke_credits_graphics"),
                  shadow = true,
                  scale = scale * 0.8,
                  colour = G.C.UI.TEXT_LIGHT
                }
              },
              {
                n = G.UIT.T,
                config = {
                  text = "GayCoonie, Joey J. Jester, Larantula, The Kuro, Lemmanade",
                  shadow = true,
                  scale = scale * 0.8,
                  colour = G.C.BLUE
                }
              }
            },
          },
          {
            n = G.UIT.R,
            config = {
              padding = 0,
              align = "cm"
            },
            nodes = {
              {
                n = G.UIT.T,
                config = {
                  text = localize("poke_credits_graphics"),
                  shadow = true,
                  scale = scale * 0.8,
                  colour = G.C.UI.TEXT_LIGHT
                }
              },
              {
                n = G.UIT.T,
                config = {
                  text = "Yamper, MyDude, Numbuh 214, SMG9000, Sonfive, PrincessRoxie",
                  shadow = true,
                  scale = scale * 0.8,
                  colour = G.C.BLUE
                }
              }
            },
          },
          {
            n = G.UIT.R,
            config = {
              padding = 0,
              align = "cm"
            },
            nodes = {
              {
                n = G.UIT.T,
                config = {
                  text = localize("poke_credits_graphics"),
                  shadow = true,
                  scale = scale * 0.8,
                  colour = G.C.UI.TEXT_LIGHT
                }
              },
              {
                n = G.UIT.T,
                config = {
                  text = "Catzzadilla, bt, KatRoman",
                  shadow = true,
                  scale = scale * 0.8,
                  colour = G.C.BLUE
                }
              }
            },
          },
          {
            n = G.UIT.R,
            config = {
              padding = 0,
              align = "cm"
            },
            nodes = {
              {
                n = G.UIT.T,
                config = {
                  text = localize("poke_credits_quality_assurance_main"),
                  shadow = true,
                  scale = scale * 0.8,
                  colour = G.C.UI.TEXT_LIGHT
                }
              },
              {
                n = G.UIT.T,
                config = {
                  text = "Lemmanade, drspectred",
                  shadow = true,
                  scale = scale * 0.8,
                  colour = G.C.BLUE
                }
              }
            }
          },
          {
            n = G.UIT.R,
            config = {
              padding = 0,
              align = "cm"
            },
            nodes = {
              {
                n = G.UIT.T,
                config = {
                  text = localize("poke_credits_sound"),
                  shadow = true,
                  scale = scale * 0.8,
                  colour = G.C.UI.TEXT_LIGHT
                }
              },
              {
                n = G.UIT.T,
                config = {
                  text = "Dread",
                  shadow = true,
                  scale = scale * 0.8,
                  colour = G.C.BLUE
                }
              }
            }
          },
          {
            n = G.UIT.R,
            config = {
              padding = 0,
              align = "cm"
            },
            nodes = {
              {
                n = G.UIT.T,
                config = {
                  text = localize("poke_credits_developer"),
                  shadow = true,
                  scale = scale * 0.8,
                  colour = G.C.UI.TEXT_LIGHT
                }
              },
              {
                n = G.UIT.T,
                config = {
                  text = "SDM0, Jevonnissocoolman, Ishtech, Fem, MathIsFun_, Kek",
                  shadow = true,
                  scale = scale * 0.8,
                  colour = G.C.BLUE
                }
              }
            }
          },
          {
            n = G.UIT.R,
            config = {
              padding = 0,
              align = "cm"
            },
            nodes = {
              {
                n = G.UIT.T,
                config = {
                  text = localize("poke_credits_designer"),
                  shadow = true,
                  scale = scale * 0.8,
                  colour = G.C.UI.TEXT_LIGHT
                }
              },
              {
                n = G.UIT.T,
                config = {
                  text = "Xilande, Lemmanade, PrincessRoxie, Catzzadilla",
                  shadow = true,
                  scale = scale * 0.8,
                  colour = G.C.BLUE
                }
              }
            }
          },
          {
            n = G.UIT.R,
            config = {
              padding = 0,
              align = "cm"
            },
            nodes = {
              {
                n = G.UIT.T,
                config = {
                  text = localize("poke_credits_localization"),
                  shadow = true,
                  scale = scale * 0.8,
                  colour = G.C.UI.TEXT_LIGHT
                }
              },
              {
                n = G.UIT.T,
                config = {
                  text = "Rafael, PainKiller, FlamingRok, Mr. Onyx",
                  shadow = true,
                  scale = scale * 0.8,
                  colour = G.C.BLUE
                }
              }
            }
          },
          {
            n = G.UIT.R,
            config = {
              padding = 0,
              align = "cm"
            },
            nodes = {
              {
                n = G.UIT.T,
                config = {
                  text = localize("poke_credits_localization"),
                  shadow = true,
                  scale = scale * 0.8,
                  colour = G.C.UI.TEXT_LIGHT
                }
              },
              {
                n = G.UIT.T,
                config = {
                  text = "PIPIKAI, PanbimboGD, HuyCorn, IlPastaio",
                  shadow = true,
                  scale = scale * 0.8,
                  colour = G.C.BLUE
                }
              }
            }
          },
          {
            n = G.UIT.R,
            config = {
              padding = 0,
              align = "cm"
            },
            nodes = {
              {
                n = G.UIT.T,
                config = {
                  text = localize("poke_credits_community_manager"),
                  shadow = true,
                  scale = scale * 0.8,
                  colour = G.C.UI.TEXT_LIGHT
                }
              },
              {
                n = G.UIT.T,
                config = {
                  text = "Astra, Kaethela",
                  shadow = true,
                  scale = scale * 0.8,
                  colour = G.C.BLUE
                }
              }
            }
          },
          {
            n = G.UIT.R,
            config = {
              padding = 0,
              align = "cm"
            },
            nodes = {
              {
                n = G.UIT.T,
                config = {
                  text = localize("poke_credits_special_thanks"),
                  shadow = true,
                  scale = scale * 0.8,
                  colour = G.C.UI.TEXT_LIGHT
                }
              },
              {
                n = G.UIT.T,
                config = {
                  text = "Marie|Tsunami, CBMX, ...and you!",
                  shadow = true,
                  scale = scale * 0.8,
                  colour = G.C.BLUE
                }
              }
            }
          },
          {
            n = G.UIT.R,
            config = {
              padding = 0.2,
              align = "cm",
            },
            nodes = {
              UIBox_button({
                minw = 3.85,
                button = "pokermon_github",
                label = {"Github"}
              }),
              UIBox_button({
                minw = 3.85,
                colour = HEX("9656ce"),
                button = "pokermon_discord",
                label = {"Discord"}
              })
            },
          },
        },
      }
    end
  }
end
function G.FUNCS.pokermon_github(e)
	love.system.openURL("https://github.com/InertSteak/Pokermon")
end
function G.FUNCS.pokermon_discord(e)
  love.system.openURL("https://discord.gg/AptX86Qsyz")
end
function G.FUNCS.pokermon_energy(e)
  local ttip = {set = 'Other', key = 'precise_energy_tooltip'}
  local energy_settings = {n = G.UIT.R, config = {align = "tm", padding = 0.05, scale = 0.75, colour = G.C.CLEAR}, nodes = {}}
  create_menu_toggles(energy_settings, energy_toggles)
  
  local t = create_UIBox_generic_options({ back_func = G.ACTIVE_MOD_UI and "openModUI_"..G.ACTIVE_MOD_UI.id or 'your_collection',
      contents = {energy_settings}
  })
  G.FUNCS.overlay_menu{definition = t}
end
function G.FUNCS.pokermon_joker_pool(e)
  local joker_pool_settings = {n = G.UIT.R, config = {align = "tm", padding = 0.05, scale = 0.75, colour = G.C.CLEAR}, nodes = {}}
  create_menu_toggles(joker_pool_settings, joker_pool_toggles)
  
  local t = create_UIBox_generic_options({ back_func = G.ACTIVE_MOD_UI and "openModUI_"..G.ACTIVE_MOD_UI.id or 'your_collection',
      contents = {joker_pool_settings}
  })
  G.FUNCS.overlay_menu{definition = t}
end
function G.FUNCS.pokermon_misc_no_restart(e)
  local misc_no_restart_settings = {n = G.UIT.R, config = {align = "tm", padding = 0.05, scale = 0.75, colour = G.C.CLEAR}, nodes = {}}
  create_menu_toggles(misc_no_restart_settings, misc_no_restart_toggles)
  
  local t = create_UIBox_generic_options({ back_func = G.ACTIVE_MOD_UI and "openModUI_"..G.ACTIVE_MOD_UI.id or 'your_collection',
      contents = {misc_no_restart_settings}
  })
  G.FUNCS.overlay_menu{definition = t}
end
function G.FUNCS.pokermon_content(e)
  local content_settings = {n = G.UIT.R, config = {align = "tm", padding = 0.05, scale = 0.75, colour = G.C.CLEAR}, nodes = {}}
  create_menu_toggles(content_settings, content_toggles)
  
  local t = create_UIBox_generic_options({ back_func = G.ACTIVE_MOD_UI and "openModUI_"..G.ACTIVE_MOD_UI.id or 'your_collection',
      contents = {content_settings}
  })
  G.FUNCS.overlay_menu{definition = t}
end
function G.FUNCS.pokermon_visual(e)
  local visual_settings = {n = G.UIT.R, config = {align = "tm", padding = 0.05, scale = 0.75, colour = G.C.CLEAR}, nodes = {}}
  create_menu_toggles(visual_settings, visual_toggles)
  
  local t = create_UIBox_generic_options({ back_func = G.ACTIVE_MOD_UI and "openModUI_"..G.ACTIVE_MOD_UI.id or 'your_collection',
      contents = {visual_settings}
  })
  G.FUNCS.overlay_menu{definition = t}
end
function G.FUNCS.pokermon_misc_restart(e)
  local misc_restart_settings = {n = G.UIT.R, config = {align = "tm", padding = 0.05, scale = 0.75, colour = G.C.CLEAR}, nodes = {}}
  create_menu_toggles(misc_restart_settings, misc_restart_toggles)
  
  local t = create_UIBox_generic_options({ back_func = G.ACTIVE_MOD_UI and "openModUI_"..G.ACTIVE_MOD_UI.id or 'your_collection',
      contents = {misc_restart_settings}
  })
  G.FUNCS.overlay_menu{definition = t}
end

--Reserve Area for Pocket packs (adapted from betmma)
local G_UIDEF_use_and_sell_buttons_ref=G.UIDEF.use_and_sell_buttons
    function G.UIDEF.use_and_sell_buttons(card)
        if (card.area == G.pack_cards and G.pack_cards) and card.ability.consumeable then --Add a use button
            if (G.STATE == G.STATES.SMODS_BOOSTER_OPENED and SMODS.OPENED_BOOSTER.label:find("Pocket")) or (G.GAME.poke_save_all and not SMODS.OPENED_BOOSTER.label:find("Wish")) or (card.ability.name == 'megastone') then
                return {
                    n=G.UIT.ROOT, config = {padding = -0.1,  colour = G.C.CLEAR}, nodes={
                      {n=G.UIT.R, config={ref_table = card, r = 0.08, padding = 0.1, align = "bm", minw = 0.5*card.T.w - 0.15, minh = 0.7*card.T.h, maxw = 0.7*card.T.w - 0.15, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = true, button = 'use_card', func = 'can_use_consumeable'}, nodes={
                        {n=G.UIT.T, config={text = localize('b_use'),colour = G.C.UI.TEXT_LIGHT, scale = 0.55, shadow = true}}
                      }},
                      {n=G.UIT.R, config={ref_table = card, r = 0.08, padding = 0.1, align = "bm", minw = 0.5*card.T.w - 0.15, maxw = 0.9*card.T.w - 0.15, minh = 0.1*card.T.h, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = true, button = 'Can Reserve', func = 'can_reserve_card'}, nodes={
                        {n=G.UIT.T, config={text = localize('b_save'),colour = G.C.UI.TEXT_LIGHT, scale = 0.45, shadow = true}}
                      }},
                      {n=G.UIT.R, config = {align = "bm", w=7.7*card.T.w}},
                      {n=G.UIT.R, config = {align = "bm", w=7.7*card.T.w}},
                      {n=G.UIT.R, config = {align = "bm", w=7.7*card.T.w}},
                      {n=G.UIT.R, config = {align = "bm", w=7.7*card.T.w}},
                      -- I can't explain it
                  }}
            end
        end
        return G_UIDEF_use_and_sell_buttons_ref(card)
    end
    G.FUNCS.can_reserve_card = function(e)
        if #G.consumeables.cards < G.consumeables.config.card_limit then 
            e.config.colour = G.ARGS.LOC_COLOURS.pink
            e.config.button = 'reserve_card' 
        else
          e.config.colour = G.C.UI.BACKGROUND_INACTIVE
          e.config.button = nil
        end
    end
    G.FUNCS.reserve_card = function(e) -- only works for consumeables
        local c1 = e.config.ref_table
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.1,
            func = function()
              c1.area:remove_card(c1)
              c1:add_to_deck()
              if c1.children.price then c1.children.price:remove() end
              c1.children.price = nil
              if c1.children.buy_button then c1.children.buy_button:remove() end
              c1.children.buy_button = nil
              remove_nils(c1.children)
              G.consumeables:emplace(c1)
              G.GAME.pack_choices = G.GAME.pack_choices - 1
              if G.GAME.pack_choices <= 0 then
                G.FUNCS.end_consumeable(nil, delay_fac)
              end
              return true
            end
        }))
    end
    G.FUNCS.reserve_card_to_joker_slot = function(e) -- only works for consumeables
        local c1 = e.config.ref_table
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.1,
            func = function()
              c1.area:remove_card(c1)
              c1:add_to_deck()
              if c1.children.price then c1.children.price:remove() end
              c1.children.price = nil
              if c1.children.buy_button then c1.children.buy_button:remove() end
              c1.children.buy_button = nil
              remove_nils(c1.children)
              G.jokers:emplace(c1)
              G.GAME.pack_choices = G.GAME.pack_choices - 1
              if G.GAME.pack_choices <= 0 then
                G.FUNCS.end_consumeable(nil, delay_fac)
              end
              return true
            end
        }))
    end

G.FUNCS.your_collection_pokemon_page = function(args)
  if not args or not args.cycle_config then return end
  for j = 1, #G.your_collection do
    for i = #G.your_collection[j].cards,1, -1 do
      local c = G.your_collection[j]:remove_card(G.your_collection[j].cards[i])
      c:remove()
      c = nil
    end
  end
  local row_start = 1 + (12 * (args.cycle_config.current_option - 1))
  for i = 1, 3 do
    for j = row_start, row_start + 3 do
      local akeys = args.cycle_config.keys
      local key = (type(akeys[j]) == "table" and akeys[j].key) or akeys[j]
      if not akeys[j] then break end
      local card = Card(G.your_collection[i].T.x + G.your_collection[i].T.w/2, G.your_collection[i].T.y, G.CARD_W, G.CARD_H, nil, G.P_CENTERS[key])
        if type(akeys[j]) == "table" then
          card.ability.extra.form = akeys[j].form
          G.P_CENTERS[key]:set_sprites(card)
        end
        G.your_collection[i]:emplace(card)
    end
    row_start = row_start + 4
  end
  INIT_COLLECTION_CARD_ALERTS()
end

poke_joker_page = 1

create_UIBox_pokedex_jokers = function(keys, previous_menu)
  local deck_tables = {}
  G.your_collection = {}
  if #keys > 4 and #keys < 13 then
    local rows = math.ceil(#keys/4)
    local marker = 1
    for i = 1, rows do
      G.your_collection[i] = CardArea(
      G.ROOM.T.x + 0.2*G.ROOM.T.w/2,G.ROOM.T.h,
      4*G.CARD_W,
      0.95*G.CARD_H, 
      {card_limit = 4, type = 'title', highlight_limit = 0, collection = true})
    table.insert(deck_tables, 
    {n=G.UIT.R, config={align = "cm", padding = 0.07, no_fill = true}, nodes={
      {n=G.UIT.O, config={object = G.your_collection[i]}}
    }}
  )
      local lastcard = math.min(marker + 3, #keys)
      for j = marker, lastcard do
        local key = (type(keys[j]) == "table" and keys[j].key) or keys[j]
        local card = Card(G.your_collection[i].T.x + G.your_collection[i].T.w/2, G.your_collection[i].T.y, G.CARD_W, G.CARD_H, nil, G.P_CENTERS[key])
        if type(keys[j]) == "table" then
          card.ability.extra.form = keys[j].form
          G.P_CENTERS[key]:set_sprites(card)
        end
        G.your_collection[i]:emplace(card)
      end
      marker = marker + 4
    end
  elseif #keys > 12 then
    local rows = 3
    local marker = 1
    for i = 1, rows do
      G.your_collection[i] = CardArea(
      G.ROOM.T.x + 0.2*G.ROOM.T.w/2,G.ROOM.T.h,
      4*G.CARD_W,
      0.95*G.CARD_H, 
      {card_limit = 4, type = 'title', highlight_limit = 0, collection = true})
    table.insert(deck_tables, 
    {n=G.UIT.R, config={align = "cm", padding = 0.07, no_fill = true}, nodes={
      {n=G.UIT.O, config={object = G.your_collection[i]}}
    }}
  )
      local lastcard = math.min(marker + 3, #keys)
      for j = marker, lastcard do
        local key = (type(keys[j]) == "table" and keys[j].key) or keys[j]
        local card = Card(G.your_collection[i].T.x + G.your_collection[i].T.w/2, G.your_collection[i].T.y, G.CARD_W, G.CARD_H, nil, G.P_CENTERS[key])
        if type(keys[j]) == "table" then
          card.ability.extra.form = keys[j].form
          G.P_CENTERS[key]:set_sprites(card)
        end
        G.your_collection[i]:emplace(card)
      end
      marker = marker + 4
    end
  else
    G.your_collection[1] = CardArea(
      G.ROOM.T.x + 0.2*G.ROOM.T.w/2,G.ROOM.T.h,
      math.min(4, #keys)*G.CARD_W,
      0.95*G.CARD_H, 
      {card_limit = #keys, type = 'title', highlight_limit = 0, collection = true})
    table.insert(deck_tables, 
    {n=G.UIT.R, config={align = "cm", padding = 0.07, no_fill = true}, nodes={
      {n=G.UIT.O, config={object = G.your_collection[1]}}
    }}
    )
    
    for i = 1, #keys do
      local key = (type(keys[i]) == "table" and keys[i].key) or keys[i]
      local card = Card(G.your_collection[1].T.x + G.your_collection[1].T.w/2, G.your_collection[1].T.y, G.CARD_W, G.CARD_H, nil, G.P_CENTERS[key])
      if type(keys[i]) == "table" then
        card.ability.extra.form = keys[i].form
        G.P_CENTERS[key]:set_sprites(card)
      end
      G.your_collection[1]:emplace(card)
    end
  end
  local t = nil
  if #keys <= 12 then
    t =  create_UIBox_generic_options({ back_func = previous_menu or 'exit_overlay_menu', contents = {
          {n=G.UIT.R, config={align = "cm", r = 0.1, colour = G.C.BLACK, emboss = 0.05}, nodes=deck_tables}, 
      }})
  else
    local joker_options = {}
    for i = 1, math.ceil(#keys/(4*#G.your_collection)) do
      table.insert(joker_options, localize('k_page')..' '..tostring(i)..'/'..tostring(math.ceil(#keys/(4*#G.your_collection))))
    end
    t =  create_UIBox_generic_options({ back_func = previous_menu or 'exit_overlay_menu', contents = {
        {n=G.UIT.R, config={align = "cm", r = 0.1, colour = G.C.BLACK, emboss = 0.05}, nodes=deck_tables}, 
        {n=G.UIT.R, config={align = "cm"}, nodes={
          create_option_cycle({options = joker_options, w = 4.5, cycle_shoulders = true, opt_callback = 'your_collection_pokemon_page', current_option = 1, keys = keys, colour = G.C.RED, no_pips = true, focus_args = {          snap_to = true, nav = 'wide'}})
        }}
    }})
  end
  return t
end

G.FUNCS.pokedexui = function(e)
  if G.STAGE == G.STAGES.RUN then
    if G.jokers and G.jokers.highlighted and G.jokers.highlighted[1] then
      local selected = G.jokers.highlighted[1]
      if selected.config.center.stage then
        G.FUNCS.overlay_menu{
          definition = create_UIBox_pokedex_jokers(get_family_keys(selected.config.center.name, selected.config.center.poke_custom_prefix, selected)),
        }
      end
    end
  end
end

G.FUNCS.pokedex_back = function()
  G.FUNCS.your_collection_jokers()
  G.FUNCS.SMODS_card_collection_page({cycle_config = {current_option = poke_joker_page}})
  local page = G.OVERLAY_MENU:get_UIE_by_ID('cycle_shoulders').children[1].children[1]
  page.config.ref_table.current_option = poke_joker_page
  page.config.ref_table.current_option_val = page.config.ref_table.options[poke_joker_page]
end

-- Functionality for Pokedex View
SMODS.Keybind({
    key = "openPokedex",
    key_pressed = "p",
    action = function(controller)
        G.FUNCS.pokedexui()
    end
})

local controller_queue_R_cursor_press_ref = Controller.queue_R_cursor_press
function Controller:queue_R_cursor_press(x, y)
    controller_queue_R_cursor_press_ref(self, x, y)
    local clicked = self.hovering.target or self.focused.target
    if clicked and type(clicked) == 'table' and clicked.config and type(clicked.config) == 'table' and clicked.config.center and clicked.facing ~= 'back' then
      if clicked.config.center.stage or clicked.config.center.poke_multi_item then
        local menu = G.SETTINGS.paused and 'pokedex_back' or nil
        if menu and G.OVERLAY_MENU:get_UIE_by_ID('cycle_shoulders') then poke_joker_page = G.OVERLAY_MENU:get_UIE_by_ID('cycle_shoulders').children[1].children[1].config.ref_table.current_option end
        if menu and clicked.config.center.poke_multi_item then menu = 'your_collection_consumables' end
        G.FUNCS.overlay_menu{
          definition = create_UIBox_pokedex_jokers(get_family_keys(clicked.config.center.name, clicked.config.center.poke_custom_prefix, clicked), menu),
        }
      end
    end
end

local poke_capture_focused_input = Controller.capture_focused_input
function Controller:capture_focused_input(button, input_type, dt)
  if self.focused then
    local clicked = self.focused.target
    if input_type == 'press' and button == 'rightstick' then
      if clicked and type(clicked) == 'table' and clicked.config and type(clicked.config) == 'table' and clicked.config.center and clicked.facing ~= 'back' then
        if clicked.config.center.stage or clicked.config.center.poke_multi_item then
          local menu = G.SETTINGS.paused and 'pokedex_back' or nil
          if menu and G.OVERLAY_MENU:get_UIE_by_ID('cycle_shoulders') then poke_joker_page = G.OVERLAY_MENU:get_UIE_by_ID('cycle_shoulders').children[1].children[1].config.ref_table.current_option end
          if menu and clicked.config.center.poke_multi_item then menu = 'your_collection_consumables' end
          G.SETTINGS.paused = true
          G.FUNCS.overlay_menu{
            definition = create_UIBox_pokedex_jokers(get_family_keys(clicked.config.center.name, clicked.config.center.poke_custom_prefix, clicked), menu),
          }
          self:update_focus()
        end
      end
    end
  end
  
  return poke_capture_focused_input(self, button, input_type, dt)
end