extends ActionEffect
##ActionEffect for dealing and applying damage.
class_name DamageEffect

##The amount of damage dealt.
@export var damage_amount:int = 1
##The damage type dealt.
@export var damage_type:DamageType
##Notes if the damage comes from a spell or not.
@export var is_spell:bool = false

func apply(
			user:CharacterInstance,
			targets:Array[CharacterInstance],
			#battle:BattleManager - don't need this yet
		):
	var result:EffectResult = EffectResult.new()
	var debug_string:String = ""
	
	result.user = user
	result.is_spell = is_spell
	
	for i in targets:
		var character:CharacterResult = CharacterResult.new()
		character.character = i
		character.old_health = i.get_statistic("current_health_points")
		
		var affinity:GameState.AFFINITY = i.affinities[damage_type]
		var damage:int = user.get_statistic("magic") * damage_amount if is_spell else user.get_statistic("attack") + damage_amount
		var was_alive = !i.character_down
		# TODO: Balance critical damage handling. Logic currently taken straight from Gen 1 Pokémon, but using the Critical statistic instead of Speed.
		var is_crit = randi_range(0,255) < floori(user.get_statistic("critical")/2)
		
		character.is_crit = is_crit
		
		if !is_spell: damage = floori(damage * 1.5) if is_crit else damage
		var heal_debug:bool = false
		
		match affinity:
			GameState.AFFINITY.NORMAL:
				damage -= floori(i.get_statistic("defense")/5.0)
				damage = max(1, damage)
				i.take_damage(damage)
			GameState.AFFINITY.WEAK:
				damage += floori(user.get_statistic("magic")/1.5) if is_spell else floori(user.get_statistic("attack")/1.5)
				damage = max(0, damage)
				i.take_damage(damage)
			GameState.AFFINITY.RESIST:
				damage -= floori(i.get_statistic("defense")/2.0)
				damage = max(1, damage)
				i.take_damage(damage)
			GameState.AFFINITY.IMMUNE:
				damage = 0 # No damage dealt!
			GameState.AFFINITY.ABSORB:
				damage += floori(i.get_statistic("defense")/4.0)
				damage = -max(1, damage)
				i.heal(damage)
				heal_debug = true
		
		character.effective_hp_change = damage
		
		if was_alive && i.character_down:
			character.downed = true
		
		character.new_health = i.get_statistic("current_health_points")
		
		result.targets.append(character)
		
		if heal_debug: debug_string += "Healed Character \"" + i.character_name + "\"\n"
	
	result.additional_debug_message = debug_string if !debug_string.is_empty() else "None"
	return result
