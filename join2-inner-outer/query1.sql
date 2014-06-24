-- Show a list of all cadets and awards they have won, if any.
SELECT cadet.id, cadet.name, cadet.callsign, award.name  
FROM cadet, LEFT OUTER JOIN award ON award.cadet_id = cadet.id  
WHERE cadet.name IS NOT NULL  
ORDER BY cadet.name
LIMIT 10;