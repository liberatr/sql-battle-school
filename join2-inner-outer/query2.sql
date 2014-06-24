-- Show the first 10 battles by Dragon Army, and if Andrew Wiggin fought in them, show his battle info.
SELECT battle.id, battle.date, battle.winner, cadet.name, cadet_battle.frozen, cadet_battle.num_frozen, cadet_battle.frozen_by, cadet_battle.shots, cadet_battle.toon_id, cadet_battle.mvp
FROM battle, LEFT OUTER JOIN cadet_battle ON cadet_battle.battle_id = battle.id, JOIN cadet ON cadet.id = cadet_battle.cadet_id
WHERE army1_id = 1 OR army2_id = 1 AND cadet_battle.cadet_id = 1  
ORDER BY battle.date
LIMIT 10; 