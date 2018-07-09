local E, L, V, P, G = unpack(ElvUI)
local EP = LibStub("LibElvUIPlugin-1.0", true)
local AS = E:NewModule("AddOnSkins")
AS.LSM = LibStub("LibSharedMedia-3.0")

local AddOnName = ...

local select = select
local lower = string.lower

local GetAddOnInfo = GetAddOnInfo

local addonList = {
	"Omen",
	"Recount",
	"SexyCooldown",
	"DBM",
	"Skada",
	"Auctionator",
	"BugSack",
	"CallToArms",
	"Postal",
	"QuestPointer",
	"Clique",
	"FloAspectBar",
	"FloTotemBar",
	"Spy",
	"AtlasLoot",
	"Atlas",
	"FlightMap",
	"WeakAuras",
	"Overachiever",
	"OpenGF",
	"KHunterTimers",
	"TellMeWhen",
	"GearScore",
	"AllStats",
	"BlackList",
	"GnomishVendorShrinker",
	"ACP",
	"EveryQuest",
	"_NPCScan",
	"MoveAnything",
	"VanasKoS",
	"BindPad",
	"ZygorGuidesViewer",
	"ZygorTalentAdvisor",
	"WowLua",
	"ChatBar",
	"Skillet",
	"TotemTimers",
	"PlateBuffs",
	"MageNuggets",
	"InspectEquip",
	"AdvancedTradeSkillWindow",
	"AtlasQuest",
	"AckisRecipeList",
	"LightHeaded",
	"Carbonite",
	"Enchantrix",
	"FishingBuddy",
	"Talented",
	"TinyPad",
	"ZOMGBuffs",
	"BuyEmAll",
	"Doom_CooldownPulse",
	"AdiBags",
	"PallyPower",
	"KarniCrap",
	"TradeskillInfo",
	"PAB",
	"EPGP",
	"EPGP_LootMaster",
	"RaidRoll",
	"RaidCooldowns",
	"EventAlert",
	"WIM",
	"BigWigs",
	"Outfitter",
	"Poisoner",
	"TrinketMenu",
	"Stalker",
	"ChocolateBar",
}

AS.addOns = {}

for i = 1, GetNumAddOns() do
	local name, _, _, enabled = GetAddOnInfo(i)
	AS.addOns[lower(name)] = enabled ~= nil
end

function AS:CheckAddOn(addon)
	return self.addOns[lower(addon)] or false
end

local IsAddOnLoaded, C_Timer = IsAddOnLoaded, C_Timer
function AS:CheckOption(optionName, ...)
	for i = 1, select('#', ...) do
		local addon = select(i, ...)
		if not addon then break end
		if not IsAddOnLoaded(addon) then return false end
	end

	return E.db.addOnSkins[optionName]
end

function AS:IsAddonExist(addon)
	return self.addOns[lower(addon)] ~= nil
end

function AS:RegisterAddonOption(addonName, options)
	if select(6, GetAddOnInfo(addonName)) == "MISSING" then return end

	options.args.skins.args.addOns.args[addonName] = {
		type = "toggle",
		name = addonName,
		desc = L["TOGGLESKIN_DESC"],
		hidden = function() return not self:CheckAddOn(addonName) end
	}
end

local function ColorizeSettingName(settingName)
	return string.format("|cff1784d1%s|r", settingName)
end

local positionValues = {
	TOPLEFT = "TOPLEFT",
	LEFT = "LEFT",
	BOTTOMLEFT = "BOTTOMLEFT",
	RIGHT = "RIGHT",
	TOPRIGHT = "TOPRIGHT",
	BOTTOMRIGHT = "BOTTOMRIGHT",
	CENTER = "CENTER",
	TOP = "TOP",
	BOTTOM = "BOTTOM"
}

local function getOptions()
	local options = {
		order = 50,
		type = "group",
		childGroups = "tab",
		name = ColorizeSettingName(L["AddOn Skins"]),
		args = {
			skins = {
				order = 1,
				type = "group",
				childGroups = "tab",
				name = L["Skins"],
				args = {
					header = {
						order = 1,
						type = "header",
						name = L["Skins"]
					},
					addOns = {
						order = 1,
						type = "group",
						name = L["AddOn Skins"],
						get = function(info) return E.private.addOnSkins[info[#info]] end,
						set = function(info, value)
							E.private.addOnSkins[info[#info]] = value
							E:StaticPopup_Show("PRIVATE_RL")
						end,
						args = {
							header = {
								order = 1,
								type = "header",
								name = L["AddOn Skins"]
							}
						}
					},
					blizzard = {
						order = 2,
						type = "group",
						name = L["Blizzard Skins"],
						get = function(info) return E.private.addOnSkins[info[#info]] end,
						set = function(info, value)
							E.private.addOnSkins[info[#info]] = value
							E:StaticPopup_Show("PRIVATE_RL")
						end,
						args = {
							header = {
								order = 1,
								type = "header",
								name = L["Blizzard Skins"]
							},
							Blizzard_WorldStateFrame = {
								order = 2,
								type = "toggle",
								name = "WorldStateFrame",
								desc = L["TOGGLESKIN_DESC"],
							}
						}
					}
				}
			},
			misc = {
				order = 2,
				type = "group",
				childGroups = "tab",
				name = L["Misc Options"],
				args = {
					header = {
						order = 1,
						type = "header",
						name = L["Misc Options"],
					},
					skadaGroup = {
						order = 2,
						type = "group",
						name = "Skada",
						get = function(info) return E.db.addOnSkins[info[#info]] end,
						set = function(info, value)
							E.db.addOnSkins[info[#info]] = value
							Skada:ApplySettings()
						end,
						disabled = function() return not AS:CheckAddOn("Skada") end,
						args = {
							skadaTemplate = {
								order = 1,
								type = "select",
								name = L["Template"],
								values = {
									["Default"] = L["Default"],
									["Transparent"] = L["Transparent"],
									["NoBackdrop"] = NONE
								}
							},
							skadaTemplateGloss = {
								order = 2,
								type = "toggle",
								name = L["Template Gloss"],
								disabled = function() return E.db.addOnSkins.skadaTemplate ~= "Default" or not AS:CheckAddOn("Skada") end
							},
							spacer = {
								order = 3,
								type = "description",
								name = ""
							},
							skadaTitleTemplate = {
								order = 4,
								type = "select",
								name = L["Title Template"],
								values = {
									["Default"] = L["Default"],
									["Transparent"] = L["Transparent"],
									["NoBackdrop"] = NONE
								}
							},
							skadaTitleTemplateGloss = {
								order = 5,
								type = "toggle",
								name = L["Title Template Gloss"],
								disabled = function() return E.db.addOnSkins.skadaTitleTemplate ~= "Default" or not AS:CheckAddOn("Skada") end
							}
						}
					},
					dbmGroup = {
						order = 3,
						type = "group",
						name = "DBM",
						get = function(info) return E.db.addOnSkins[info[#info]] end,
						set = function(info, value)
							E.db.addOnSkins[info[#info]] = value
							DBM.Bars:ApplyStyle()
							DBM.BossHealth:UpdateSettings()
						end,
						disabled = function() return not AS:CheckAddOn("DBM-Core") end,
						args = {
							dbmBarHeight = {
								order = 1,
								type = "range",
								min = 6, max = 60, step = 1,
								name = "Bar Height"
							},
							dbmFont = {
								order = 2,
								type = "select",
								dialogControl = "LSM30_Font",
								name = L["Font"],
								values = AceGUIWidgetLSMlists.font
							},
							dbmFontSize = {
								order = 3,
								type = "range",
								min = 6, max = 22, step = 1,
								name = L["Font Size"]
							},
							dbmFontOutline = {
								order = 4,
								type = "select",
								name = L["Font Outline"],
								values = {
									["NONE"] = L["None"],
									["OUTLINE"] = "OUTLINE",
									["MONOCHROMEOUTLINE"] = "MONOCROMEOUTLINE",
									["THICKOUTLINE"] = "THICKOUTLINE"
								}
							}
						}
					},
					waGroup = {
						order = 4,
						type = "group",
						name = "WeakAuras",
						get = function(info) return E.db.addOnSkins[info[#info]] end,
						set = function(info, value)
							E.db.addOnSkins[info[#info]] = value
							E:StaticPopup_Show("PRIVATE_RL")
						end,
						disabled = function() return not AS:CheckAddOn("WeakAuras") end,
						args = {
							weakAuraAuraBar = {
								order = 1,
								type = "toggle",
								name = L["AuraBar Backdrop"]
							},
							weakAuraIconCooldown = {
								order = 2,
								type = "toggle",
								name = L["Icon Cooldown"]
							}
						}
					},
					chatBarGroup = {
						order = 5,
						type = "group",
						name = "ChatBar",
						get = function(info) return E.db.addOnSkins[info[#info]] end,
						set = function(info, value)
							E.db.addOnSkins[info[#info]] = value
							ChatBar_UpdateButtonOrientation()
							ChatBar_UpdateButtons()
						end,
						disabled = function() return not AS:CheckAddOn("ChatBar") end,
						args = {
							chatBarSize = {
								order = 1,
								type = "range",
								min = 0, max = 60, step = 1,
								name = "Button Size"
							},
							chatBarSpacing = {
								order = 2,
								type = "range",
								min = 0, max = 60, step = 1,
								name = "Button Spacing"
							},
							chatBarTextPoint = {
								order = 3,
								type = "select",
								name = L["Text Position"],
								values = positionValues
							},
							chatBarTextXOffset = {
								order = 4,
								type = "range",
								min = -300, max = 300, step = 1,
								name = L["Text xOffset"],
								desc = L["Offset position for text."]
							},
							chatBarTextYOffset = {
								order = 5,
								type = "range",
								min = -300, max = 300, step = 1,
								name = L["Text yOffset"],
								desc = L["Offset position for text."]
							}
						}
					},
					bwGroup = {
						order = 6,
						type = "group",
						name = "BigWigs",
						get = function(info) return E.db.addOnSkins[info[#info]] end,
						set = function(info, value) E.db.addOnSkins[info[#info]] = value end,
						disabled = function() return not AS:CheckAddOn("BigWigs") end,
						args = {
							bigwigsBarHeight = {
								order = 1,
								type = "range",
								min = 10, max = 40, step = 1,
								name = "Bar Height"
							},
							bigwigsFontSize = {
								order = 2,
								type = "range",
								min = 6, max = 22, step = 1,
								name = L["Font Size"]
							},
							bigwigsFontOutline = {
								order = 3,
								type = "select",
								name = L["Font Outline"],
								values = {
									["NONE"] = L["None"],
									["OUTLINE"] = "OUTLINE",
									["MONOCHROMEOUTLINE"] = "MONOCROMEOUTLINE",
									["THICKOUTLINE"] = "THICKOUTLINE"
								}
							}
						}
					}
				}
			},
			embed = {
				order = 3,
				type = "group",
				name = "Embed Settings",
				get = function(info) return E.db.addOnSkins.embed[info[#info]] end,
				set = function(info, value)
					E.db.addOnSkins.embed[info[#info]] = value
					E:GetModule("EmbedSystem"):EmbedUpdate()
				end,
				args = {
					desc = {
						order = 1,
						type = "description",
						name = "Settings to control Embedded AddOns: Available Embeds: Omen | Skada | Recount ",
					},
					embedType = {
						order = 2,
						type = "select",
						name = L["Embed Type"],
						values = {
							["DISABLE"] = L["Disable"],
							["SINGLE"] = L["Single"],
							["DOUBLE"] = L["Double"]
						},
					},
					leftWindow = {
						order = 3,
						type = "select",
						name = L["Left Panel"],
						values = {
							["Recount"] = "Recount",
							["Omen"] = "Omen",
							["Skada"] = "Skada"
						},
						disabled = function() return E.db.addOnSkins.embed.embedType == "DISABLE" end
					},
					rightWindow = {
						order = 4,
						type = "select",
						name = L["Right Panel"],
						values = {
							["Recount"] = "Recount",
							["Omen"] = "Omen",
							["Skada"] = "Skada"
						},
						disabled = function() return E.db.addOnSkins.embed.embedType ~= "DOUBLE" end
					},
					leftWindowWidth = {
						order = 5,
						type = "range",
						min = 100, max = 300, step = 1,
						name = L["Left Window Width"]
					},
					hideChat = {
						order = 6,
						type = "select",
						name = "Hide Chat Frame",
						values = E:GetModule("EmbedSystem"):GetChatWindowInfo(),
						disabled = function() return E.db.addOnSkins.embed.embedType == "DISABLE" end
					},
					rightChatPanel = {
						order = 7,
						type = "toggle",
						name = "Embed into Right Chat Panel"
					},
					belowTopTab = {
						order = 8,
						type = "toggle",
						name = "Embed Below Top Tab"
					}
				}
			}
		}
	}

	for _, addonName in ipairs(addonList) do
		AS:RegisterAddonOption(addonName, options)
	end

	E.Options.args.addOnSkins = options
end

function AS:UpdateMedia()
	AS.Blank = AS.LSM:Fetch('background', 'ElvUI Blank')
	AS.Font = AS.LSM:Fetch('font', E.db.general.font)
	AS.ActionBarFont = AS.LSM:Fetch('font', 'Arial')
	AS.PixelFont = AS.LSM:Fetch('font', 'ElvUI Pixel')
	AS.NormTex = AS.LSM:Fetch('statusbar', E.private.general.normTex)
	AS.BackdropColor = E['media'].backdropcolor
	AS.BorderColor = E['media'].bordercolor
	AS.PixelPerfect = E.PixelMode
	AS.ValueColor = E["media"].rgbvaluecolor
	AS.HideShadows = false
	AS.TexCoords = E.TexCoords

	E:GetModule('DataTexts'):RegisterLDB()
	E:GetModule('DataTexts'):LoadDataTexts()
	E:UpdateMedia()
end

function AS:Initialize()
	EP:RegisterPlugin(AddOnName, getOptions)

	AS:UpdateMedia()
end

local function InitializeCallback()
	AS:Initialize()
end

E:RegisterModule(AS:GetName(), InitializeCallback)