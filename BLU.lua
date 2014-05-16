-------------------------------------------------------------------------------------------------------------------
-- Initialization function that defines sets and variables to be used.
-------------------------------------------------------------------------------------------------------------------

-- IMPORTANT: Make sure to also get the Mote-Include.lua file to go with this.

-- Initialization function for this job file.
function get_sets()
	-- Load and initialize the include file.
	include('Mote-Include.lua')
end


-- Setup vars that are user-independent.
function job_setup()

	blue_magic_maps = {}
	
	-- Physical spells with no stat mods
	blue_magic_maps.Physical = S{
		'Asuran Claws','Bludgeon','Body Slam','Feather Storm','Mandibular Bite',
		'Queasyshroom','Power Attack','Ram Charge','Screwdriver','Sickle Slash',
		'Smite of Rage','Spinal Cleave','Spiral Spin','Terror Touch'
	}

	-- Physical spells with Str stat mod
	blue_magic_maps.PhysicalStr = S{
		'Battle Dance','Bloodrake','Death Scissors','Dimensional Death',
		'Empty Thrash','Heavy Strike','Quadrastrike','Uppercut','Tourbillion',
		'Vertical Cleave'
	}
		
	-- Physical spells with Dex stat mod
	blue_magic_maps.PhysicalDex = S{
		'Amorphic Spikes','Barbed Crescent','Claw Cyclone','Disseverment',
		'Foot Kick','Frenetic Rip','Goblin Rush','Hysteric Barrage',
		'Paralyzing Triad','Seedspray','Vanity Dive'
	}
		
	-- Physical spells with Vit stat mod
	blue_magic_maps.PhysicalVit = S{
		'Cannonball','Delta Thrust','Glutinous Dart','Grand Slam',
		'Quad. Continuum','Sprout Smack'
	}
		
	-- Physical spells with Agi stat mod
	blue_magic_maps.PhysicalVit = S{
		'Benthic Typhoon','Helldive','Hydro Shot','Jet Stream','Pinecone Bomb',
		'Wild Oats'
	}

	-- Magical spells (generally Int mod)
	blue_magic_maps.Magical = S{
		'Acrid Stream','Charged Whisker','Cursed Sphere','Dark Orb','Droning Whirlwind',
		'Embalming Earth','Evryone. Grudge','Firespit','Foul Waters','Gates of Hades',
		'Leafstorm','Magic Hammer','Regurgitation','Rending Deluge','Tem. Upheaval',
		'Thermal Pulse','Water Bomb'
	}
		
	-- Magical spells (generally debuffs) that need to focus on magic accuracy
	blue_magic_maps.MagicAccuracy = S{
		'1000 Needles','Absolute Terror','Actinic Burst','Auroral Drape','Awful Eye',
		'Blank Gaze','Blistering Roar','Blood Drain','Blood Saber','Chaotic Eye',
		'Cimicine Discharge','Cold Wave','Digest','Corrosive Ooze','Demoralizing Roar',
		'Dream Flower','Enervation','Feather Tickle','Filamented Hold','Frightful Roar',
		'Geist Wall','Hecatomb Wave','Infrasonics','Jettatura','Light of Penance',
		'Lowing','Mind Blast','Mortal Ray','MP Drainkiss','Osmosis','Reaving Wind',
		'Sandspin','Sandspray','Sheep Song','Soporific','Sound Blast','Stinking Gas',
		'Sub-zero Smash','Triumphant Roar','Venom Shell','Voracious Trunk','Yawn'
	}
		
	-- Breath-based spells
	blue_magic_maps.Breath = S{
		'Bad Breath','Flying Hip Press','Final Sting','Frost Breath','Heat Breath',
		'Magnetite Cloud','Poison Breath','Radiant Breath','Self Destruct',
		'Thunder Breath','Wind Breath'
	}

	-- Stun spells
	blue_magic_maps.Stun = S{
		'Blitzstrahl','Frypan','Head Butt','Sudden Lunge','Tail slap','Temporal Shift',
		'Thunderbolt','Whirl of Rage'
	}
		
	-- Healing spells
	blue_magic_maps.Healing = S{
		'Healing Breeze','Magic Fruit','Plenilune Embrace','Pollen','White Wind',
		'Wild Carrot'
	}

	-- Other general buffs
	blue_magic_maps.Buff = S{
		'Barrier Tusk','Carcharian Verve','Cocoon','Diamondhide','Metallic Body',
		'Magic Barrier','Occultation','Orcish Counterstance',"Nature's Meditation",
		'Plasma Charge','Pyric Bulwark','Reactor Cool','Zephyr Mantle'
	}


	-- Spells that can be enhanced with Diffusion gear
        diffusion_spells = S{
                        'Amplification','Cocoon','Exuviation','Feather Barrier','Harden Shell','Memento Mori',
                        'Metallic Body','Plasma Charge','Reactor Cool','Refueling','Saline Coat','Warm-Up',
                        'Zephyr Mantle'}
 

        unbridled_spells = S{
                        'Absolute Terror','Bilgestorm','Blistering Roar','Bloodrake','Carcharian Verve',
                        'Droning Whirlwind','Gates of Hades','Harden Shell','Pyric Bulwark','Thunderbolt',
                        'Tourbillion'}
end


-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	-- Options: Override default values
	options.OffenseModes = {'Normal', 'Learning'}
	options.DefenseModes = {'Normal'}
	options.WeaponskillModes = {'Normal', 'Acc', 'Att', 'Mod'}
	options.CastingModes = {'Normal'}
	options.IdleModes = {'Normal', 'Learning'}
	options.RestingModes = {'Normal'}
	options.PhysicalDefenseModes = {'PDT'}
	options.MagicalDefenseModes = {'MDT'}

	state.Defense.PhysicalMode = 'PDT'

	select_default_macro_book()
end


-- Called when this job file is unloaded (eg: job change)
function file_unload()
	if binds_on_unload then
		binds_on_unload()
	end
end

function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	
	-- Precast Sets
	
	-- Precast sets to enhance JAs
	sets.precast.JA['Azure Lore'] = {}
	sets.precast.JA['Chain Affinity'] = {}
	sets.precast.JA['Burst Affinity'] = {}
	sets.precast.JA['Diffusion'] = {}
	sets.precast.JA['Efflux'] = {}
	sets.precast.JA['Unbridled Learning'] = {}
	sets.precast.JA['Unbridled Wisdom'] = {}
	

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {ammo="Sonia's Plectrum"}
		
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	-- Fast cast sets for spells
	
	sets.precast.FC = {ammo="Impatiens",
		head="Haruspex Hat",ear2="Loquacious Earring",
		body="Vanir Cotehardie",hands="Thaumas Gloves",ring1="Prolix Ring",
		back="Swith Cape",waist="Witful Belt",legs="Enif Cosciales",feet="Chelona Boots +1"}
		
	sets.precast.FC['Blue Magic'] = set_combine(sets.precast.FC, {body="Mavi Mintan +2"})

       
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		head="Whirlpool Mask",neck=gear.ElementalGorget,ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Qaaxo Harness",hands="Buremte Gloves",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Atheling Mantle",waist=gear.ElementalBelt,legs="Manibozho Brais",feet="Iuitl Gaiters +1"}

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {})

	sets.precast.WS['Sanguine Blade'] = {ammo="Charis Feather",
		head="Thaumas Hat",neck="Stoicheion Medal",ear1="Friomisi Earring",ear2="Hecate's Earring",
		body="Manibozho Jerkin",hands="Buremte Gloves",ring1="Rajas Ring",ring2="Demon's Ring",
		back="Toro Cape",waist="Thunder Belt",legs="Iuitl Tights",feet="Iuitl Gaiters +1"}
	
	
	-- Midcast Sets
	sets.midcast.FastRecast = {
		head="Haruspex Hat",ear2="Loquacious Earring",
		body="Vanir Cotehardie",hands="Mavi Bazubands +2",ring1="Prolix Ring",
		back="Swith Cape",waist="Goading Belt",legs="Enif Cosciales",feet="Iuitl Gaiters +1"}
		
	-- Specific spells
	sets.midcast.Utsusemi = {}
	
	sets.midcast['Blue Magic'] = {}
	
	sets.midcast['Blue Magic'].Physical = {
		head="Whirlpool Mask",neck="Asperity Necklace",
		body="Qaaxo Harness",hands="Buremte Gloves",ring1="Rajas Ring",
		waist="Caudata Belt",legs="Manibozho Brais",feet="Iuitl Gaiters +1"}
	sets.midcast['Blue Magic'].PhysicalStr = {
		head="Whirlpool Mask",neck="Asperity Necklace",
		body="Qaaxo Harness",hands="Buremte Gloves",ring1="Rajas Ring",
		waist="Caudata Belt",legs="Manibozho Brais",feet="Iuitl Gaiters +1"}
	sets.midcast['Blue Magic'].PhysicalDex = {
		head="Whirlpool Mask",neck="Asperity Necklace",
		body="Qaaxo Harness",hands="Buremte Gloves",ring1="Rajas Ring",
		waist="Caudata Belt",legs="Manibozho Brais",feet="Iuitl Gaiters +1"}
	sets.midcast['Blue Magic'].PhysicalVit = {ammo="Iron Gobbet",
		head="Whirlpool Mask",neck="Asperity Necklace",
		body="Qaaxo Harness",hands="Buremte Gloves",
		waist="Caudata Belt",legs="Manibozho Brais",feet="Iuitl Gaiters +1"}
	sets.midcast['Blue Magic'].PhysicalAgi = {
		head="Whirlpool Mask",neck="Asperity Necklace",
		body="Qaaxo Harness",hands="Buremte Gloves",ring1="Stormsoul Ring",
		waist="Caudata Belt",legs="Manibozho Brais",feet="Iuitl Gaiters +1"}
	sets.midcast['Blue Magic'].Magical = {
		head="Hagondes Hat",neck="Stoicheion Medal",ear1="Friomisi Earring",ear2="Hecate's Earring",
		body="Hagondes Coat",hands="Mavi Bazubands +2",ring1="Icesoul Ring",ring2="Strendu Ring",
		back="Toro Cape",waist="Caudata Belt",legs="Hagondes Pants",feet="Hagondes Sabots"}
	sets.midcast['Blue Magic'].MagicalAccuracy = {
		ear1="Lifestorm Earring",ear2="Psystorm Earring",
		body="Mavi Mintan +2",ring2="Sangoma Ring",
		back="Mirage Mantle",feet="Iuitl Gaiters +1"}
	sets.midcast['Blue Magic'].Breath = {
		head="Mirage Keffiyeh",neck="Lavalier +1",ear1="Lifestorm Earring",ear2="Psystorm Earring",
		body="Mavi Mintan +2",hands="Buremte Gloves",ring1="K'ayres Ring",ring2="Beeline Ring",
		back="Fravashi Mantle",legs="Enif Cosciales",feet="Iuitl Gaiters +1"}
	sets.midcast['Blue Magic'].Stun = {
		back="Mirage Mantle"}
	sets.midcast['Blue Magic'].Healing = {hands="Buremte Gloves"}
	sets.midcast['Blue Magic'].Buff = {}

	
	-- Sets to return to when not performing an action.
	
	-- Resting sets
	sets.resting = {head="Ocelomeh Headpiece +1",neck="Wiglen Gorget",
		ring1="Sheltered Ring",ring2="Paguroidea Ring",
		feet="Chelona Boots +1"}
	

	-- Idle sets
	sets.idle = {ammo="Impatiens",
		head="Whirlpool Mask",neck="Wiglen Gorget",ear1="Bloodgem Earring",ear2="Loquacious Earring",
		body="Hagondes Coat",hands="Iuitl Wristbands",ring1="Sheltered Ring",ring2="Paguroidea Ring",
		back="Shadow Mantle",waist="Flume Belt",legs="Crimson Cuisses",feet="Iuitl Gaiters +1"}

	sets.idle.Learning = {ammo="Impatiens",
		head="Whirlpool Mask",neck="Wiglen Gorget",ear1="Bloodgem Earring",ear2="Loquacious Earring",
		body="Hagondes Coat",hands="Magus Bazubands",ring1="Sheltered Ring",ring2="Paguroidea Ring",
		back="Shadow Mantle",waist="Flume Belt",legs="Crimson Cuisses",feet="Iuitl Gaiters +1"}

	sets.idle.Town = {main="Buramenk'ah", sub="Genbu's Shield",ammo="Impatiens",
		head="Mavi Kavuk +2",neck="Wiglen Gorget",ear1="Bloodgem Earring",ear2="Loquacious Earring",
		body="Mavi Mintan +2",hands="Iuitl Wristbands",ring1="Sheltered Ring",ring2="Paguroidea Ring",
		back="Atheling Mantle",waist="Flume Belt",legs="Crimson Cuisses",feet="Mavi Basmak +2"}
	
	-- Defense sets
	sets.defense.PDT = {}

	sets.defense.MDT = {}

	sets.Kiting = {legs="Crimson Cuisses"}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	-- Normal melee group
	sets.engaged = {
		head="Whirlpool Mask",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Qaaxo Harness",hands="Buremte Gloves",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Atheling Mantle",waist="Windbuffet Belt",legs="Manibozho Brais",feet="Iuitl Gaiters +1"}
	sets.engaged.Learning = {
		head="Uk'uxkaj Cap",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Qaaxo Harness",hands="Magus Bazubands",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Atheling Mantle",waist="Windbuffet Belt",legs="Manibozho Brais",feet="Iuitl Gaiters +1"}

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks that are called to process player actions at specific points in time.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic target handling to be done.
function job_pretarget(spell, action, spellMap, eventArgs)

end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)

end

-- Run after the default precast() is done.
-- eventArgs is the same one used in job_precast, in case information needs to be persisted.
function job_post_precast(spell, action, spellMap, eventArgs)

end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
	if spell.action_type == 'Magic' then
		-- Default base equipment layer of fast recast.
		equip(sets.midcast.FastRecast)
	end
end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)

end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)

end

-- Run after the default aftercast() is done.
-- eventArgs is the same one used in job_aftercast, in case information needs to be persisted.
function job_post_aftercast(spell, action, spellMap, eventArgs)

end

-------------------------------------------------------------------------------------------------------------------
-- Customization hooks for idle and melee sets, after they've been automatically constructed.
-------------------------------------------------------------------------------------------------------------------

-- Called before the Include starts constructing melee/idle/resting sets.
-- Can customize state or custom melee class values at this point.
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_handle_equipping_gear(status, eventArgs)

end

-- Custom spell mapping.
-- Return custom spellMap value that can override the default spell mapping.
-- Don't return anything to allow default spell mapping to be used.
function job_get_spell_map(spell, default_spell_map)
	if spell.skill == 'Blue Magic' then
		for category,spell_list in pairs(blue_magic_maps) do
			if spell_list:contains(spell.english) then
				return category
			end
		end
	end
end

-- Return a customized weaponskill mode to use for weaponskill sets.
-- Don't return anything if you're not overriding the default value.
function get_custom_wsmode(spell, action, spellMap)

end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
	return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
	return meleeSet
end

-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------

-- Called when the player's status changes.
function job_status_change(newStatus, oldStatus, eventArgs)

end

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)

end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called for custom player commands.
function job_self_command(cmdParams, eventArgs)

end

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)

end

-- Job-specific toggles.
function job_toggle(field)

end

-- Request job-specific mode lists.
-- Return the list, and the current value for the requested field.
function job_get_mode_list(field)

end

-- Set job-specific mode values.
-- Return true if we recognize and set the requested field.
function job_set_mode(field, val)

end

-- Handle auto-targetting based on local setup.
function job_auto_change_target(spell, action, spellMap, eventArgs)

end

-- Handle notifications of user state values being changed.
function job_state_change(stateField, newValue)

end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)

end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'WAR' then
		set_macro_page(1, 7)
	else
		set_macro_page(1, 7)
	end
end
