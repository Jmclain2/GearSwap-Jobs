-------------------------------------------------------------------------
--                         Gear Set Definitions                        --
-------------------------------------------------------------------------

function get_sets()
	sets.precast = {}
	sets.midcast = {}
	sets.aftercast = {}
	
	sets.mnd = {
		head  = "Circe's Hat",
		neck  = "Justice Badge",
		body  = "Brigandine +1",
		hands = "Zealot's Mitts",
		ring1 = "Serenity Ring",
		ring2 = "Serenity Ring",
		back  = "White Cape +1",
		waist = "Penitent's Rope",
		legs  = "Custom Slacks",
		feet  = "Shade Leggings +1" --placeholder
	}
	
	sets.int = {
		head  = "Baron's Chapeau",
		ear1  = "Phtm. Earring +1",
		ear2  = "Phtm. Earring +1",
		body  = "Brigandine +1",
		hands = "Custom M Gloves", --placeholder
		ring1 = "Genius Ring",
		ring2 = "Genius Ring",
		back  = "Black Cape +1",
		waist = "Penitent's Rope",
		legs  = "Mage's Slacks",
		feet  = "Custom M Boots"
	}

	sets.mp = {
		neck  = "Beak Necklace +1",
		ear1  = "Phtm. Earring +1",
		ear2  = "Phtm. Earring +1",
		body  = "Royal Cloak",
		hands = "Custom M Gloves",
		ring1 = "Astral Ring",
		ring2 = "Astral Ring",
		waist = "Friar's Rope",
		legs  = "Custom Slacks",
		feet  = "Custom M Boots"
	}

	sets.fastcast = {

	}

	sets.cure = {
		main  = "Chatoyant Staff"
	}

	sets.haste = {
		waist = "Headlong Belt"
	}

	sets.tp = {
		main  = "Wis.Wiz. Anelace",
		sub   = "Balance Buckler",
		head  = "Valkyrie's Mask",
		neck  = "Spike Necklace",
		ear1  = "Spike Earring",
		ear2  = "Spike Earring",
		body  = "Royal Cloak",
		hands = "Custom M Gloves",
		ring1 = "Woodsman Ring",
		ring2 = "Woodsman Ring",
		back  = "Exact. Mantle +1",
		waist = "Life Belt",
		legs  = "C.C. Slacks +2",
		feet  = "Mettle Leggings"
	}

	sets.elemental = {
		main = "Chatoyant Staff",
		neck = "Elemental Torque",
		ear2 = "Elemental Earring"
	}

	sets.enfeebling = {
		main = "Chatoyant Staff",
		neck = "Enfeebling Torque",
		ear2 = "Enfeebling Earring"
	}

	sets.enhancing = {
		neck = "Enhancing Torque",
		ear2 = "Augment. Earring"
	}

	sets.idle = {
		body  = "Royal Cloak"
	}
	
	sets.resting = {
		main  = "Chatoyant Staff",
		body  = "Royal Cloak",
		waist = "Reverend Sash",
		neck  = "Beak Necklace +1"
	}
	
	sets.engaged = {
		
	}

	sets.midcast["Haste"] = set_combine(sets.haste, sets.fastcast)
	sets.midcast["Refresh"] = set_combine(sets.haste, sets.fastcast)

	-- While under main job 30, override presets for Destrier Beret
	if player.main_job_level <= 30 then
		set_combine(sets.idle, {head = "Destrier Beret"})
		set_combine(sets.resting, {head = "Destrier Beret"})
		set_combine(sets.engaged, {head = "Destrier Beret"})
	end

end

-------------------------------------------------------------------------
--                          Status Change Rules                        --
-------------------------------------------------------------------------

-- Change default gear based on current combat status
function status_change(status)

	if player.status == "Idle" then
		equip(sets.idle)
	end

	if player.status == "Resting" then
		equip( set_combine( sets.mp, sets.resting ) )
	end

	if player.status == "Engaged" then
		equip(sets.engaged)
	end

end

-------------------------------------------------------------------------
--                             Casting Rules                           --
-------------------------------------------------------------------------

-- Haste/Fast Cast Gear
function precast(spell)
	
	if spell.action_type == "Magic" then
		equip( set_combine( sets.haste, sets.fastcast ) )
	end

	if spell.action_type == "Weapon Skill" then
		--equip(sets.precast.weapon_skill)
	end
	
end

-- Potency/Attributes Gear
function midcast(spell)

	-- If an exception rule exists for the spell/ability, use that instead
	if sets.midcast[spell.name] then
		equip(sets.midcast[spell.name])
		return

	-- MP Exception rule
	elseif player.mpp > 90 and (spell.skill == "Enhancing Magic" or spell.skill == "Healing Magic") then
		return

	else -- If no exception exists, use fallback rules

		-- Healing Spells
		if spell.name:startswith("Cure") or spell.name:startswith("Cura") then
			equip(set_combine(sets.mnd, sets.cure))
		end

		-- Enfeebling Spells
		if spell.skill == "Enfeebling Magic" then
			if spell.type == "WhiteMagic" then
				equip(set_combine(sets.mnd, sets.enfeebling))
			elseif spell.type == "BlackMagic" then
				equip(set_combine(sets.int, sets.enfeebling))
			end
		end

		-- Enhancing Spells
		if spell.skill == "Enhancing Magic" then
			equip(set_combine(sets.mnd, sets.enhancing))			
		end

		-- Nukes Spells
		if spell.skill == "Elemental Magic" then
			equip(set_combine(sets.int, sets.elemental))			
		end
	end
	
	equip(sets.midcast)
end

-- Resting State Gear
function aftercast(spell)
	
	if player.status == "Idle" then
		equip(sets.mp)
	end

	if player.status == "Engaged" then
		equip(sets.tp)
	end
end

-------------------------------------------------------------------------
--                          Support Functions                          --
-------------------------------------------------------------------------

function self_command(command)

	-- Toggle between Light and Dark arts
	if command == "toggle" then

		if buffactive["Light Arts"] then
			send_command('input /ja "Dark Arts" <me>')

		else
			send_command('input /ja "Light Arts" <me>')

		end
	end


end