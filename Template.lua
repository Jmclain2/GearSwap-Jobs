function get_sets()
	sets.precast = {}
	sets.precast.fast_cast = {}
	sets.precast.weapon_skill = {}

	sets.midcast = {}
	sets.midcast.int = {}
	sets.midcast.mnd = {}
	sets.midcast.cure_potency = {}
	sets.midcast.enfeebling = {}
	sets.midcast.elemental = {}

	sets.aftercast = {}

	sets.idle = {}
	sets.resting = {}
	sets.engaged = {}
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
		equip(sets.precast.fast_cast)
	end

	if spell.action_type == "Weapon Skill" then
		equip(sets.precast.weapon_skill)
	end
	
end

-- Potency/Attributes Gear
function midcast(spell)

	-- If an exception rule exists for the spell, use that instead
	if sets.midcast[spell.name] then
		equip sets.midcast[spell.name]

	else -- If no exception exists, use fallback rules

		-- Healing Spells
		if spell.name:startswith("Cure") or spell.name:startswith("Cura") then
			equip(sets.midcast.cure_potency)
		end

		-- Enfeebling Spells
		if spell.skill == "Enfeebling Magic" then
			
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