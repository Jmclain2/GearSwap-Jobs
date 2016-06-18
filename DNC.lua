function get_sets()
	sets.precast = {}
	sets.midcast = {}
	sets.aftercast = {}
	
	sets.chr = {
		neck = "Bird Whistle",
		ring1 = "Hope Ring",
		ring2 = "Hope Ring +1"
	}

	sets.idle = {
		neck = "Focus Collar +1",
		ring1 = "Balance Ring",
		ring2 = "Balance Ring"
	}
	
	sets.resting = {}
	
	sets.engaged = {
		neck = "Focus Collar +1",
		ring1 = "Balance Ring",
		ring2 = "Balance Ring"
	}


	-- Equip Destrier Beret if current job level is eligible
	if player.main_job_level <= 30 then
		set_combine(sets.idle, {head = "Destrier Beret"})
		set_combine(sets.engaged, {head = "Destrier Beret"})
		set_combine(sets.resting, {head = "Destrier Beret"})
	end

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
		--equip(sets.precast.weapon_skill)
	end
	
end

-- Potency/Attributes Gear
function midcast(spell)

	-- If an exception rule exists for the spell, use that instead
	if sets.midcast[spell.name] then
		equip(sets.midcast[spell.name])

	else -- If no exception exists, use fallback rules

		-- Healing Spells
		if spell.name:startswith("Curing") then
			equip(sets.chr)
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