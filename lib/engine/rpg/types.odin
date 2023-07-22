package rpg

Stats :: struct {
	currHP: int,
	maxHp: int,
	attack: int,
	accuracy: int,
}

StatsGrowth :: struct {
	hp: f32,
	attack: f32,
	accuracy: f32,
}

Character :: struct {
	availableSkills: map[string]bool,
	activeSkills: map[string]bool,
	baseStats: Stats,
	modifiedStats: Stats,
	class: ^Class,
	xp: int,
	level: int,
}
// TODO
Equipment :: struct {
	stats: Stats,
	cost: int,
}

ALLY_ROSTER_SIZE :: 4
ENEMY_ROSTER_SIZE :: 4

AllyRoster :: [ALLY_ROSTER_SIZE]Character
EnemyRoster :: [ENEMY_ROSTER_SIZE]Character

Skill :: struct {
	isValidTargets: proc(AllyRoster, EnemyRoster),
	use: proc(AllyRoster, EnemyRoster),
}

Class :: struct { 
	leveledSkills: map[int]string,
	defaultSkills: [dynamic]string,
	baseStats: Stats,
	statGrowth: StatsGrowth,
}

SkillPool :: map[string]Skill
