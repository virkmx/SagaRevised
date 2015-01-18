-- Saga is Licensed under Creative Commons Attribution-NonCommerial-ShareAlike 3.0 License
-- http://creativecommons.org/licenses/by-nc-sa/3.0/
-- Generated By Quest Extractor on 2/8/2008 3:46:15 PM

local QuestID = 128;
local ReqClv = 9;
local ReqJlv = 0;
local NextQuest = 344;
local RewZeny = 323;
local RewCxp = 208;
local RewJxp = 0;
local RewWxp = 0; 
local RewItem1 = 1700113; 
local RewItem2 = 0; 
local RewItemCount1 = 8; 
local RewItemCount2 = 0; 

-- Modify steps below for gameplay

function QUEST_START(cid)
	Saga.AddStep(cid, QuestID, 12801);
	Saga.AddStep(cid, QuestID, 12802);
	Saga.InsertQuest(cid, QuestID, 2);
	return 0;
end

function QUEST_FINISH(cid)
	local freeslots = Saga.FreeInventoryCount(cid, 0);
	if freeslots > 0 then
	Saga.GiveZeny(RewZeny);
	Saga.GiveExp( RewCxp, RewJxp, RewWxp);
	Saga.GiveItem(cid, RewItem1, RewItemCount1 );
	Saga.GiveItem(cid, RewItem2, RewItemCount2 );	
	    return 0;
    else    	
	    return -1;
	end
end
function QUEST_CANCEL(cid)
	return 0;
end

function QUEST_STEP_1(cid)
	Saga.StepComplete(cid, QuestID, 12801);
	return 0;

function QUEST_STEP_2(cid)
--Talk with Scacciano Morrigan

	Saga.AddWaypoint(cid, QuestID, 12802, 1, 1003);

--completion check
	local ret = Saga.GetNpcIndex(cid);
	if ret == 1003
then
	Saga.GeneralDialog(cid, 3936);
	Saga.SubStepComplete(cid, QuestID, 12602, 1);
end
--check if all substeps are complete
	for i = 1, 1 do
	if IsSubStepCompleted(cid, QuestID, 12802, i) == false
then
	return -1
	end
end
	Saga.StepComplete(cid, QuestID, 12602);
	Saga.ClearWaypoints(cid, QuestID);
	Saga.QuestComplete(cid, QuestID);
	return -1;
end

function QUEST_CHECK(cid)
	-- Check all steps for progress
	local CurStepID = Saga.GetStepIndex(cid, QuestID );
	local ret = -1;

	if CurStepID == 12801 then
		ret = QUEST_STEP_1(cid);
	elseif CurStepID == 12802 then
		ret = QUEST_STEP_2(cid);
	end

	if ret == 0 then
		QUEST_CHECK(cid)
	end

	return ret;
end

	