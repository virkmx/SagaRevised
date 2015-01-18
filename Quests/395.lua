-- Saga is Licensed under Creative Commons Attribution-NonCommerial-ShareAlike 3.0 License
-- http://creativecommons.org/licenses/by-nc-sa/3.0/
-- Generated By Quest Extractor on 2/8/2008 3:46:18 PM

local QuestID = 395;
local ReqClv = 25;
local ReqJlv = 0;
local NextQuest = 0;
local RewZeny = 792;
local RewCxp = 6314;
local RewJxp = 2526;
local RewWxp = 0; 
local RewItem1 = 1700114; 
local RewItem2 = 0; 
local RewItemCount1 = 5; 
local RewItemCount2 = 0; 
local StepID = 0;   

-- Modify steps below for gameplay

function QUEST_START(cid)    
    Saga.AddStep(cid, QuestID, 39501);
    Saga.AddStep(cid, QuestID, 39502);       
    Saga.AddStep(cid, QuestID, 39503);
    Saga.InsertQuest(cid, QuestID, 1);  
    return 0;
end

function QUEST_FINISH(cid)
    -- Gives all rewards
    Saga.GiveItem(cid, RewItem1, RewItemCount1 );        
    Saga.GiveZeny(cid, RewZeny);
    Saga.GiveExp(cid, RewCxp, RewJxp, RewWxp); 
    return 0;
end

function QUEST_CANCEL(cid)
    return 0;
end

function QUEST_STEP_1(cid)
    -- Talk with Volker Stanwood
    Saga.AddWaypoint(cid, QuestID, StepID, 1, 1009);      
    
    -- Check for completion
    local ret = Saga.GetNPCIndex(cid);    
    if ret == 1009 then
        Saga.GeneralDialog(cid, 3936);      
        Saga.SubstepComplete(cid, QuestID, StepID, 1); 
    end    
    
    -- Check if all substeps are completed
    for i = 1, 1 do
         if Saga.IsSubStepCompleted(cid,QuestID,StepID, i) == false then
            return -1;
         end
    end        
    
    Saga.StepComplete(cid, QuestID, StepID);
    Saga.ClearWaypoints(cid, QuestID); 
    return 0;
end

function QUEST_STEP_2(cid)
    -- Eliminate Golden Culvert Thief Bug (1)
    Saga.Eliminate(cid, QuestID, StepID,10143, 1, 1);
	
    -- Check if all substeps are completed
    for i = 1, 1 do
         if Saga.IsSubStepCompleted(cid,QuestID,StepID, i) == false then
			return -1;
		 end
    end	
    
    Saga.StepComplete(cid, QuestID, StepID);  
    return 0;
end

function QUEST_STEP_3(cid)
    -- Talk with Volker Stanwood
    Saga.AddWaypoint(cid, QuestID, StepID, 1, 1009);      
    
    -- Check for completion
    local ret = Saga.GetNPCIndex(cid);    
    if ret == 1009 then
        Saga.GeneralDialog(cid, 3936);      
        Saga.SubstepComplete(cid, QuestID, StepID, 1); 
    end    
    
    -- Check if all substeps are completed
    for i = 1, 1 do
         if Saga.IsSubStepCompleted(cid,QuestID,StepID, i) == false then
            return -1;
         end
    end        
    
    Saga.StepComplete(cid, QuestID, StepID);
    Saga.ClearWaypoints(cid, QuestID); 
    Saga.QuestComplete(cid, QuestID);    
    return -1;
end

function QUEST_CHECK(cid)
    local CurStepID = Saga.GetStepIndex(cid, QuestID );
    StepID = CurStepID;
    local ret = -1;

    if CurStepID == 39501 then
        ret = QUEST_STEP_1(cid);
    elseif CurStepID == 39502 then                       
        ret = QUEST_STEP_2(cid);                       
    elseif CurStepID == 39503 then                       
        ret = QUEST_STEP_3(cid);             
    end
    
    if ret == 0 then
        QUEST_CHECK(cid)
    end
    
    return ret;    
end