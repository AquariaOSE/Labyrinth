--
-- utility functions for cutscenes
--

if not v then v = {} end



function v.quickFlash(t)
	fade2(1, t, 1, 1, 1)
	playSfx("memory-flash", 0, 0.5)
	watch(t)
	fade2(0, t, 1, 1, 1)
	watch(t)
end

