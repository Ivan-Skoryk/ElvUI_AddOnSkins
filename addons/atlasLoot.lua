local E, L, V, P, G, _ = unpack(ElvUI);
local addon = E:GetModule("AddOnSkins");

if(not addon:CheckAddOn("AtlasLoot")) then return; end

function addon:AtlasLoot()
	local S = E:GetModule("Skins");
	
	AtlasLootTooltip:HookScript("OnShow", function(self)
		self:SetTemplate("Transparent");
		
		local iLink = select(2, self:GetItem());
		local quality = iLink and select(3, GetItemInfo(iLink));
		if(quality and quality >= 2) then
			self:SetBackdropBorderColor(GetItemQualityColor(quality));
		else
			self:SetBackdropBorderColor(unpack(E["media"].bordercolor));
		end
	end);
	
	AtlasLootDefaultFrame:StripTextures();
	AtlasLootDefaultFrame:SetTemplate("Transparent");
	
	S:HandleCloseButton(AtlasLootDefaultFrame_CloseButton);
	S:HandleButton(AtlasLootDefaultFrame_LoadModules);
	S:HandleButton(AtlasLootDefaultFrame_Options);
	S:HandleButton(AtlasLootDefaultFrame_Menu);
	S:HandleButton(AtlasLootDefaultFrame_SubMenu);
	AtlasLootDefaultFrame_LootBackground:SetTemplate("Default", nil, true);
	AtlasLootDefaultFrame_LootBackground_Back:SetTexture(0, 0, 0, 0);
	S:HandleButton(AtlasLootDefaultFrame_Preset1);
	S:HandleButton(AtlasLootDefaultFrame_Preset2);
	S:HandleButton(AtlasLootDefaultFrame_Preset3);
	S:HandleButton(AtlasLootDefaultFrame_Preset4);
	S:HandleEditBox(AtlasLootDefaultFrameSearchBox);
	AtlasLootDefaultFrameSearchBox:SetPoint("BOTTOM", AtlasLootDefaultFrame, "BOTTOM", -78, 30);
	AtlasLootDefaultFrameSearchBox:Height(22);
	S:HandleButton(AtlasLootDefaultFrameSearchButton);
	AtlasLootDefaultFrameSearchButton:SetPoint("LEFT", AtlasLootDefaultFrameSearchBox, "RIGHT", 3, 0);
	S:HandleNextPrevButton(AtlasLootDefaultFrameSearchOptionsButton);
	AtlasLootDefaultFrameSearchOptionsButton:SetPoint("LEFT", AtlasLootDefaultFrameSearchButton, "RIGHT", 2, 0);
	AtlasLootDefaultFrameSearchOptionsButton:SetSize(24, 24);
	S:HandleButton(AtlasLootDefaultFrameSearchClearButton);
	AtlasLootDefaultFrameSearchClearButton:SetPoint("LEFT", AtlasLootDefaultFrameSearchOptionsButton, "RIGHT", 2, 0);
	S:HandleButton(AtlasLootDefaultFrameLastResultButton);
	AtlasLootDefaultFrameLastResultButton:SetPoint("LEFT", AtlasLootDefaultFrameSearchClearButton, "RIGHT", 2, 0);
	S:HandleButton(AtlasLootDefaultFrameWishListButton);
	AtlasLootDefaultFrameWishListButton:SetPoint("RIGHT", AtlasLootDefaultFrameSearchBox, "LEFT", -2, 0);
	
	S:HandleCloseButton(AtlasLootItemsFrame_CloseButton);
	
	S:HandleButton(AtlasLootInfoHidePanel);
	
	for i = 1, 30 do
		_G["AtlasLootItem_" .. i .. "_Icon"]:SetTexCoord(unpack(E.TexCoords));
		_G["AtlasLootItem_" .. i]:CreateBackdrop("Default");
		_G["AtlasLootItem_" .. i].backdrop:SetOutside(_G["AtlasLootItem_" .. i .. "_Icon"]);
		
		_G["AtlasLootMenuItem_" .. i .. "_Icon"]:SetTexCoord(unpack(E.TexCoords));
		_G["AtlasLootMenuItem_" .. i]:CreateBackdrop("Default");
		_G["AtlasLootMenuItem_" .. i].backdrop:SetOutside(_G["AtlasLootMenuItem_" .. i .. "_Icon"]);
	end
	
	S:HandleButton(AtlasLoot10Man25ManSwitch);
	S:HandleCheckBox(AtlasLootItemsFrame_Heroic);
	S:HandleButton(AtlasLootItemsFrame_BACK);
	S:HandleNextPrevButton(AtlasLootItemsFrame_NEXT);
	S:HandleButton(AtlasLootServerQueryButton);
	S:HandleNextPrevButton(AtlasLootQuickLooksButton);
	S:HandleCheckBox(AtlasLootFilterCheck);
	S:HandleNextPrevButton(AtlasLootItemsFrame_PREV);
	
	AtlasLootItemsFrame_Back:SetTexture(0, 0, 0, 0);
	
	S:HandleCheckBox(AtlasLootOptionsFrameDefaultTT);
	S:HandleCheckBox(AtlasLootOptionsFrameLootlinkTT);
	S:HandleCheckBox(AtlasLootOptionsFrameItemSyncTT);
	S:HandleCheckBox(AtlasLootOptionsFrameOpaque);
	S:HandleCheckBox(AtlasLootOptionsFrameItemID);
	S:HandleCheckBox(AtlasLootOptionsFrameLoDStartup);
	S:HandleCheckBox(AtlasLootOptionsFrameSafeLinks);
	S:HandleCheckBox(AtlasLootOptionsFrameEquipCompare);
	S:HandleCheckBox(AtlasLootOptionsFrameItemSpam);
	S:HandleCheckBox(AtlasLootOptionsFrameHidePanel);
	
	S:HandleDropDownBox(AtlasLoot_SelectLootBrowserStyle);
	S:HandleDropDownBox(AtlasLoot_CraftingLink);
	
	S:HandleSliderFrame(AtlasLootOptionsFrameLootBrowserScale);
	
	S:HandleButton(AtlasLootOptionsFrame_ResetWishlist);
	S:HandleButton(AtlasLootOptionsFrame_ResetAtlasLoot);
	S:HandleButton(AtlasLootOptionsFrame_ResetQuicklooks);
	S:HandleButton(AtlasLootOptionsFrame_FuBarShow);
	S:HandleButton(AtlasLootOptionsFrame_FuBarHide);
	
	AtlasLootPanel:StripTextures();
	AtlasLootPanel:SetTemplate("Transparent");
	
	S:HandleButton(AtlasLootPanel_WorldEvents);
	AtlasLootPanel_WorldEvents:SetPoint("LEFT", AtlasLootPanel, "LEFT", 7, 29);
	S:HandleButton(AtlasLootPanel_Sets);
	AtlasLootPanel_Sets:SetPoint("LEFT", AtlasLootPanel_WorldEvents, "RIGHT", 2, 0);
	S:HandleButton(AtlasLootPanel_Reputation);
	AtlasLootPanel_Reputation:SetPoint("LEFT", AtlasLootPanel_Sets, "RIGHT", 2, 0);
	S:HandleButton(AtlasLootPanel_PvP);
	AtlasLootPanel_PvP:SetPoint("LEFT", AtlasLootPanel_Reputation, "RIGHT", 2, 0);
	S:HandleButton(AtlasLootPanel_Crafting);
	AtlasLootPanel_Crafting:SetPoint("LEFT", AtlasLootPanel_PvP, "RIGHT", 2, 0);
	S:HandleButton(AtlasLootPanel_WishList);
	AtlasLootPanel_WishList:SetPoint("LEFT", AtlasLootPanel_Crafting, "RIGHT", 2, 0);
	S:HandleButton(AtlasLootPanel_Options);
	S:HandleButton(AtlasLootPanel_LoadModules);
	S:HandleButton(AtlasLootPanel_Preset1);
	S:HandleButton(AtlasLootPanel_Preset2);
	S:HandleButton(AtlasLootPanel_Preset3);
	S:HandleButton(AtlasLootPanel_Preset4);
	
	S:HandleEditBox(AtlasLootSearchBox);
	AtlasLootSearchBox:Height(20);
	S:HandleButton(AtlasLootSearchButton);
	AtlasLootSearchButton:Height(22);
	AtlasLootSearchButton:SetPoint("LEFT", AtlasLootSearchBox, "RIGHT", 3, 0);
	S:HandleNextPrevButton(AtlasLootSearchOptionsButton);
	AtlasLootSearchOptionsButton:SetPoint("LEFT", AtlasLootSearchButton, "RIGHT", 2, 0);
	S:HandleButton(AtlasLootSearchClearButton);
	AtlasLootSearchClearButton:Height(22);
	AtlasLootSearchClearButton:SetPoint("LEFT", AtlasLootSearchOptionsButton, "RIGHT", 2, 0);
	S:HandleButton(AtlasLootLastResultButton);
	AtlasLootLastResultButton:Height(22);
	AtlasLootLastResultButton:SetPoint("LEFT", AtlasLootSearchClearButton, "RIGHT", 2, 0);
	
	hooksecurefunc("AtlasLoot_SetupForAtlas", function()
		AtlasLootPanel:ClearAllPoints();
		AtlasLootPanel:SetParent(AtlasFrame);
		AtlasLootPanel:SetPoint("TOP", "AtlasFrame", "BOTTOM", 0, -2);
	end);
end

addon:RegisterSkin("AtlasLoot", addon.AtlasLoot);