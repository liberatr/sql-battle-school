-- Show a list of cadets and the names of cadets who froze them in battle.
SELECT c1.cadet_id, c1.name, c1.army_id, cb.battle_id, cb.hits_taken, c2.name, c2.army_id  
FROM cadet AS c1 JOIN cadet_battle AS cb ON cb.cadet_id = c1.cadet_id LEFT JOIN cadet AS c2 ON c2.cadet_id = cb.frozen_by_id  
WHERE c1.name IS NOT NULL  
ORDER BY c1.army_id  
LIMIT 20;