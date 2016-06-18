function get_sets()
	sets.precast = {}
	sets.midcast = {}
	sets.aftercast = {}
	
	sets.mnd = {
		ring1="Saintly Ring +1",
		ring2="Saintly Ring +1",
		back="Mist Silk Cape",
		hands="Zealot's Mitts",
		neck="Justice Badge",
		waist="Friar's Rope"
	}
	
	sets.int = {
		ring1="Eremite's Ring +1",
		ring2="Eremite's Ring +1",
		hands="Cuffs +1",
		head="Baron's Chapeau"
	}

	sets.idle = {head="Destrier beret"}
	
	sets.resting = {head="Destrier beret"}
	
	sets.engaged = {
		head="Destrier beret",
		back="Traveler's Mantle",
		hands="Battle Gloves"
	}
end

-- Change default gear based on current combat status
function status_change(status)

	if player.status == "Idle" then
		equip(sets.idle)
	end

	if player.status == "Resting" then
		equip(sets.resting)
	end

	if player.status == "Engaged" then
		equip(sets.engaged)
	end

end

-- Haste/Fast Cast Gear
function precast(spell)
	
	if spell.action_type == "Magic" then
		equip(sets.precast)
	end

	if spell.action_type == "Weapon Skill" then
		equip(sets.precast)
	end
	
end

-- Potency/Attributes Gear
function midcast(spell)

	-- If an exception rule exists for the spell, use that instead
	if sets.midcast[spell.name] then
		equip(sets.midcast[spell.name])

	else -- If no exception exists, use fallback rules

		-- Healing Spells
		if spell.name:startswith("Cure") or spell.name:startswith("Cura") then
			equip(sets.mnd)
		end

		-- Nukes
		if spell.skill == "Elemental Magic" or spell.skill == "Dark Magic" then
			equip(sets.int)
		end

		-- Enfeebling Spells
		if spell.skill == "Enfeebling Magic" then
			
			if spell.name == "Slow" or spell.name == "Paralyze" then
				equip(sets.mnd)

			elseif spell.name == "Blind" then
				equip(sets.int)

			end

		end

		-- Bar Spells
		if spell.name:startswith("Bar") then
			
		end
	end
	
	equip(sets.midcast)
end

-- Resting State Gear
function aftercast(spell)
	
	if player.status == "Idle" then
		equip(sets.idle)
	end

	if player.status == "Engaged" then
		equip(sets.engaged)
	end
end