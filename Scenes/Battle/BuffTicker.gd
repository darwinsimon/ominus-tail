extends Node
class_name BuffTicker

#######################
### Public functions
#######################

func add_buff(ch : Character, buff : Buff):
	
	if buff.is_debuff:
		print("Added debuff " + buff.buff_name + " for " + ch.char_name)
		ch.debuffs.append(buff)
	else:
		print("Added buff " + buff.buff_name + " for " + ch.char_name)
		ch.buffs.append(buff)

	buff.connect("on_dispelled", self, "_on_buff_dispelled")

func tick_buff(chars):
	for ch in chars:
		for b in range(ch.buffs.size()):
			ch.buffs[b].incr_turn()
			if ch.buffs[b].is_expired():
				print("Removing buff " + ch.buffs[b].buff_name + " from " + ch.char_name)
				ch.buffs.remove(b)
				b -= 1
			
		for db in range(ch.debuffs.size()):
			
			var hp_damage = ch.debuffs[db].hp_damage(ch.curr_hp, ch.max_hp)
			if hp_damage > 0:
				print(hp_damage)
			
			ch.debuffs[db].incr_turn()
			if ch.debuffs[db].is_expired():
				print("Removing debuff " + ch.buffs[db].buff_name + " from " + ch.char_name)
				ch.debuffs.remove(db)
				db -= 1

#######################
### Signal listeners
#######################

func _on_buff_dispelled(buff : Buff):
	pass
