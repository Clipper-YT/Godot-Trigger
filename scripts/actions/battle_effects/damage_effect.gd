extends ActionEffect
##ActionEffect for dealing and applying damage.
class_name DamageEffect

##The amount of damage dealt.
@export var damage_amount:int = 1
##The damage type dealt.
@export var damage_type:DamageType
##Notes if the damage comes from a spell or not.
@export var is_spell:bool

func apply(
			user:CharacterInstance,
			targets:Array[CharacterInstance],
			#battle:BattleManager - don't need this yet
		):
	var downed_characters:Array[CharacterInstance] = []
	
	for i in targets:
		var affinity:GameState.AFFINITY = i.affinities[damage_type]
		var damage:int = floori(user.get_statistic("magic")/1.8) * damage_amount if is_spell else user.get_statistic("attack") + damage_amount
		var was_alive = !i.character_down
		# TODO: Balance critical damage handling. Logic currently taken straight from Gen 1 Pokémon, but using the Critical statistic instead of Speed.
		if !is_spell: damage = floori(damage * 1.5) if randi_range(0,255) <= floori(user.get_statistic("critical")/2) else damage
		match affinity:
			GameState.AFFINITY.NORMAL:
				damage -= floori(i.get_statistic("defense")/2.0)
				damage = max(1, damage)
				i.take_damage(damage)
			GameState.AFFINITY.WEAK:
				damage += floori(user.get_statistic("magic")/1.2) if is_spell else floori(user.get_statistic("attack")/1.2)
				damage = max(0, damage)
				i.take_damage(damage)
			GameState.AFFINITY.RESIST:
				damage -= i.get_statistic("defense")
				damage = max(1, damage)
				i.take_damage(damage)
			GameState.AFFINITY.IMMUNE:
				damage = 0 # No damage dealt!
			GameState.AFFINITY.ABSORB:
				damage -= floori(i.get_statistic("defense")/2.0)
				damage = max(1, damage)
				i.heal(damage)
		
		if was_alive && i.character_down:
			downed_characters.append(i)
	
	return downed_characters
