--������[ QUFEI 2008-04-30 10:27 UPDATE BugID 34168 ]
--�����ʧ�����������¼��ű�
--������������1_�ɵ��඾

--MisDescBegin
--�ű���
x500609_g_ScriptId	= 500609

--Ŀ������NPC����
x500609_g_Position_X=62.6751
x500609_g_Position_Z=162.6368
x500609_g_SceneID=1
x500609_g_AccomplishNPC_Name="Ǯ����"

--ǰ�������
x500609_g_PreMissionId	=	419
--�����
x500609_g_MissionId			= 422
--��һ�������ID
x500609_g_MissionIdNext	= 423
--��һ�������Index
x500609_g_MissionIndexNext	= 1018710
--��һ�������ScriptId
x500609_g_NextScriptId	= 006668
--��ȡ����Ŀ�����ڳ���
x500609_g_AcceptNPC_SceneID	=	1
--��ȡ����npc
x500609_g_Name 					= "Ǯ����"
--�������
x500609_g_MissionKind			= 12
--����ȼ�
x500609_g_MissionLevel		= 38
--�Ƿ��Ǿ�Ӣ����
x500609_g_IfMissionElite	= 0
--�����Ƿ��Ѿ����
x500609_g_IsMissionOkFail	= 0		--��������ĵ�0λ

--�����ı�����
x500609_g_MissionName			= "�ɵ��඾"
--��������
x500609_g_MissionInfo			= "#{YD_20080421_64}"
--����Ŀ��
x500609_g_MissionTarget		= "#{YD_20080421_63}"
--δ��������npc�Ի�
x500609_g_ContinueInfo		= "#{YD_20080421_193}"
--�������npc˵�Ļ�
x500609_g_MissionComplete	= "#{YD_20080421_65}"
--������ɵĻ���
x500609_g_MaxRound	= 1
--���ƽű�
x500609_g_ControlScript		= 001066

-- ����������,���ݶ�̬ˢ��,ռ����������ĵ�1λ
x500609_g_Custom	= { {id="��ɱ���඾",num=1} }
--MisDescEnd

--�����Ƿ����
x500609_g_Mission_IsComplete = 0		--��������ĵ�0λ
--�Ƿ�ɱ�ֵı��
x500609_g_RecordIdx 				 = 1		--��������ĵ�1λ
--����ű��ż�¼
x500609_g_MissScriptID_Idx	 = 2		--��������ĵ�2λ
--���񷢲�NPC���
x500609_g_AcceptNPC_Idx			 = 3		--��������ĵ�3λ 2.����NPC

x500609_g_AcceptMission_IDX		= 761	--������������
x500609_g_CompleteMission_IDX	= 762	--�ύ��������

--��ӵ�е��¼�ID�б�
x500609_g_EventList	= {}

x500609_g_PlayerSlow_LVL					 = 38		-- �����������͵ȼ�

--����
x500609_g_MoneyBonus					=	9475
x500609_g_ExpBonus						= 37902
x500609_g_ItemBonus_List 	 	  = { id=30505701,num=1 }

--��������ID_���ɱ߾�
x500609_g_TargetSceneId				= 47
--��������
x500609_g_MonsterName					=	"�඾"
--Ҫ���ɱ������
x500609_g_KillMonsterCnt			=	1

--**********************************
--������ں���
--**********************************
--����������ִ�д˽ű�
function x500609_OnDefaultEvent( sceneId, selfId, targetId )

	local	key	= GetNumText()	
	if key == x500609_g_AcceptMission_IDX then
		--�жϸ�npc�Ƿ��Ƕ�Ӧ�����npc
		if LuaFnGetName( sceneId, targetId ) ~= x500609_g_Name then
			x500609_NotifyTip( sceneId, selfId, "��������ʧ��" )					
			return 0
		end
		-- �����Ƿ�����
		if IsMissionFull( sceneId, selfId ) == 1 then
			x500609_NotifyTip( sceneId, selfId, "#{QIANXUN_INFO_23}" )
			return 0
		end
		
		-- ��������������
		if x500609_CheckAccept( sceneId, selfId, targetId )<=0 then
			return 0
		end

		-- ��������������			
		x500609_AcceptMission( sceneId, selfId, targetId )				
	
	elseif key == x500609_g_CompleteMission_IDX then
		--�жϸ�npc�Ƿ��Ƕ�Ӧ�����npc
		if LuaFnGetName( sceneId, targetId ) ~= x500609_g_AccomplishNPC_Name then
			x500609_NotifyTip( sceneId, selfId, "�ύ����ʧ��" )					
			return 0
		end
		-- ����Ѿ���������
		if IsHaveMission( sceneId, selfId, x500609_g_MissionId) > 0 then
												
			--���������������Ϣ
			BeginEvent(sceneId)
				AddText(sceneId, x500609_g_MissionName)
				AddText(sceneId, x500609_g_ContinueInfo)			
			EndEvent( )
			
			local bDone = x500609_CheckSubmit( sceneId, selfId, targetId )				
			DispatchMissionDemandInfo(sceneId, selfId, targetId, x500609_g_ScriptId, x500609_g_MissionId, bDone)
			
		else			
			x500609_TalkInfo( sceneId, selfId, targetId, "#{YD_20080421_178}" )
			return 0
		end
	else
		x500609_NotifyTip( sceneId, selfId, "��������ʧ��" )					
		return 0
	end

end

--**********************************
--�о��¼�
--**********************************
function x500609_OnEnumerate( sceneId, selfId, targetId )

	if IsHaveMission( sceneId, selfId, x500609_g_MissionId ) <= 0 then
		if LuaFnGetName( sceneId, targetId ) == x500609_g_Name
			 and sceneId == x500609_g_AcceptNPC_SceneID then
			if IsMissionHaveDone( sceneId, selfId, x500609_g_PreMissionId ) > 0
				 and IsMissionHaveDone( sceneId, selfId, x500609_g_MissionId ) <= 0 then
				AddNumText( sceneId, x500609_g_ScriptId, x500609_g_MissionName, 1, x500609_g_AcceptMission_IDX )
			end
		end
	else
		if LuaFnGetName( sceneId, targetId ) == x500609_g_AccomplishNPC_Name
				 and sceneId == x500609_g_SceneID then
			
			AddNumText( sceneId, x500609_g_ScriptId, x500609_g_MissionName, 2, x500609_g_CompleteMission_IDX )
		end
	end

end

--**********************************
--������������Ҳ�����������
--**********************************
function x500609_CheckAccept( sceneId, selfId, targetId )
	
	--�������Ƿ���Ͻ������������
	--�жϸ�npc�Ƿ��Ƕ�Ӧ�����npc
	if LuaFnGetName( sceneId, targetId ) ~= x500609_g_Name then
		x500609_NotifyTip( sceneId, selfId, "��������ʧ��" )					
		return 0
	end

	--���ȼ�
	if LuaFnGetLevel( sceneId, selfId ) < x500609_g_PlayerSlow_LVL then
		local nStr = format( "#{YD_20080421_175}%d#{YD_20080421_176}", x500609_g_PlayerSlow_LVL )
		x500609_TalkInfo( sceneId, selfId, targetId, nStr )
		return 0
	end

	--�Ѿ��ӹ��򲻷�������
	if IsHaveMission( sceneId, selfId, x500609_g_MissionId ) > 0 then
		x500609_TalkInfo( sceneId, selfId, targetId, "#{XSHCD_20080418_067}" )
		return 0
	end
	if IsMissionHaveDone( sceneId, selfId, x500609_g_MissionId ) > 0 then
		return 0
	end

	--���ǰ������
	if IsMissionHaveDone( sceneId, selfId, x500609_g_PreMissionId ) <= 0 then
		x500609_TalkInfo( sceneId, selfId, targetId, "#{YD_20080421_177}" )
		return 0
	end
	
	return 1
end

--**********************************
--���ܣ�����������������ù�������
--**********************************
function x500609_OnAccept( sceneId, selfId, targetId, scriptId )
	
	--�жϸ�npc�Ƿ��Ƕ�Ӧ�����npc
 	if LuaFnGetName( sceneId, targetId ) ~= x500609_g_Name then
 		x500609_NotifyTip( sceneId, selfId, "��������ʧ��" )					
		return 0
	end

	if x500609_CheckAccept( sceneId, selfId, targetId )<=0 then
		return 0
	end

	--������������б�
	local bAdd = AddMission( sceneId, selfId, x500609_g_MissionId, x500609_g_ScriptId, 1, 0, 0 )
	if bAdd >= 1 then

		--�õ���������к�
		local	misIndex		= GetMissionIndexByID( sceneId, selfId, x500609_g_MissionId )
		
		--�������кŰ���������ĵ�0λ��0 (����������)
		SetMissionByIndex( sceneId, selfId, misIndex, x500609_g_Mission_IsComplete, 0 )
		SetMissionByIndex( sceneId, selfId, misIndex, x500609_g_RecordIdx, 0 )
		--�������кŰ���������ĵ�2λ��Ϊ����ű���
		SetMissionByIndex( sceneId, selfId, misIndex, x500609_g_MissScriptID_Idx, scriptId )		
		SetMissionByIndex(sceneId, selfId, misIndex, x500609_g_AcceptNPC_Idx, 2)
		
		local strText = "#{YD_20080421_229}" .. x500609_g_MissionName
		Msg2Player( sceneId, selfId, strText, MSG2PLAYER_PARA )

	end

	return 1

end

--**********************************
--�������������������
--**********************************
function x500609_OnAbandon( sceneId, selfId )

  if IsHaveMission( sceneId, selfId, x500609_g_MissionId ) > 0 then
	 	DelMission( sceneId, selfId, x500609_g_MissionId )
	end
	
	return 0

end

--**********************************
--����
--**********************************
function x500609_OnContinue( sceneId, selfId, targetId )
	
	--�жϸ�npc�Ƿ��Ƕ�Ӧ�����npc
	if LuaFnGetName( sceneId, targetId ) ~= x500609_g_AccomplishNPC_Name then
		x500609_NotifyTip( sceneId, selfId, "�ύ����ʧ��" )					
		return 0
	end

	-- ��������Ƿ����
	if x500609_CheckSubmit( sceneId, selfId, targetId ) ~= 1 then			
		return 0
	end
	
	BeginEvent(sceneId)
		AddText(sceneId,x500609_g_MissionName)
		AddText( sceneId, x500609_g_MissionComplete )				
	EndEvent( )
	DispatchMissionContinueInfo(sceneId,selfId,targetId,x500609_g_ScriptId,x500609_g_MissionId)
	
end

--**********************************
--����Ƿ�����ύ
--**********************************
function x500609_CheckSubmit( sceneId, selfId, targetId )

	--�жϸ�npc�Ƿ��Ƕ�Ӧ�����npc
	if LuaFnGetName( sceneId, targetId ) ~= x500609_g_AccomplishNPC_Name then
		x500609_NotifyTip( sceneId, selfId, "�ύ����ʧ��" )					
		return 0
	end

	if IsHaveMission( sceneId, selfId, x500609_g_MissionId ) <= 0 then
		x500609_TalkInfo( sceneId, selfId, targetId, "#{YD_20080421_178}" )
		return 0
	end

	local misIndex = GetMissionIndexByID(sceneId,selfId,x500609_g_MissionId)

	-- ��������Ƿ����	
	if GetMissionParam(sceneId, selfId, misIndex, x500609_g_Mission_IsComplete) > 0 then
		return 1
	end
	
	return 0
	
end

--**********************************
--�ύ���������������
--**********************************
function x500609_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	
	--�жϸ�npc�Ƿ��Ƕ�Ӧ�����npc
	if LuaFnGetName( sceneId, targetId ) ~= x500609_g_AccomplishNPC_Name then
		x500609_NotifyTip( sceneId, selfId, "�ύ����ʧ��" )					
		return 0
	end

  -- ��������Ƿ����
	if x500609_CheckSubmit( sceneId, selfId, targetId ) ~= 1 then
		x500609_NotifyTip( sceneId, selfId, "�ύ����ʧ��" )				
		return 0
	end

	AddMoney( sceneId, selfId, x500609_g_MoneyBonus )
	LuaFnAddExp( sceneId, selfId, x500609_g_ExpBonus )

	-- ����˳�����
	x500609_NotifyTip( sceneId, selfId, "#{YD_20080421_180}" )

	if IsHaveMission( sceneId, selfId, x500609_g_MissionId ) > 0 then  	
	 	DelMission( sceneId, selfId, x500609_g_MissionId )
	 	-- ���������Ѿ�����ɹ�
	 	MissionCom( sceneId, selfId, x500609_g_MissionId )
	 	
	 	local strText = "#Y" .. x500609_g_MissionName .. "#{YD_20080421_230}"
		Msg2Player( sceneId, selfId, strText, MSG2PLAYER_PARA )
	 	
	 	-- ��������������ܽ���
	 	if IsHaveMission( sceneId, selfId, x500609_g_MissionIdNext ) <= 0 and IsMissionHaveDone( sceneId, selfId, x500609_g_MissionIdNext ) <= 0 then
	 		CallScriptFunction( x500609_g_NextScriptId, "OnDefaultEvent", sceneId, selfId, targetId, x500609_g_MissionIndexNext )
	 	end	 		 		 	
	end

	-- local nItemId = 0
	-- -- ���轱����Ʒ
	-- BeginAddItem(sceneId)
	-- AddItem(sceneId,x500609_g_ItemBonus_List.id, x500609_g_ItemBonus_List.num)
	-- local canAdd = EndAddItem(sceneId,selfId)						
	-- if canAdd > 0 then
	-- 	nItemId = x500609_g_ItemBonus_List.id
	-- 	AddItemListToHuman(sceneId,selfId)
	-- end

end

--**********************************
--ɱ����������
--**********************************
function x500609_OnKillObject( sceneId, selfId, objdataId ,objId)--������˼�������š����objId�������λ�úš�����

	--�Ƿ��Ǹ���
	local sceneType = LuaFnGetSceneType( sceneId )
	if sceneType ~= 1 then
		return
	end

	local monsterName = GetMonsterNamebyDataId(objdataId)
	if monsterName ~= x500609_g_MonsterName then
		return 0
	end
	
	local num = GetMonsterOwnerCount(sceneId,objId)
	for i=0,num-1  do
		-- ȡ��ӵ�з���Ȩ���˵�objId
		local humanObjId = GetMonsterOwnerID(sceneId,objId,i)
		-- PrintStr("humanObjId=" .. humanObjId)
		-- ��������ǲ������������
		if IsHaveMission(sceneId, humanObjId, x500609_g_MissionId) > 0 then
			-- ���ж��ǲ����Ѿ���������ɱ�־
			local misIndex = GetMissionIndexByID(sceneId,humanObjId,x500609_g_MissionId)
			if GetMissionParam(sceneId, humanObjId, misIndex, x500609_g_Mission_IsComplete) <=0  then
				local killedCount =	GetMissionParam(sceneId, humanObjId, misIndex, x500609_g_RecordIdx)
				killedCount = killedCount + 1
				SetMissionByIndex(sceneId, humanObjId, misIndex, x500609_g_RecordIdx, killedCount)					
				BeginEvent(sceneId)
					local str = format("��ɱ��%s%d/%d", x500609_g_MonsterName, killedCount, x500609_g_KillMonsterCnt )						
					AddText(sceneId, str)
				EndEvent(sceneId)
				DispatchMissionTips(sceneId, humanObjId)
				if killedCount >= x500609_g_KillMonsterCnt then
					SetMissionByIndex(sceneId, humanObjId, misIndex, x500609_g_Mission_IsComplete, 1)
				end
			end
		end
	end

end

--**********************************
--���������¼�
--**********************************
function x500609_OnEnterArea( sceneId, selfId, zoneId )	
end

--**********************************
--���߸ı�
--**********************************
function x500609_OnItemChanged( sceneId, selfId, itemdataId )
end

--**********************************
--���������ʾ�Ľ���
--**********************************
function x500609_AcceptDialog(sceneId, selfId, rand, g_Dialog, targetId )

	BeginEvent( sceneId )
		AddText( sceneId, g_Dialog )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )

end

--**********************************
--���������ʾ�Ľ���
--**********************************
function x500609_SubmitDialog( sceneId, selfId, rand )
end

--**********************************
--��Ŀ��ʾ
--**********************************
function x500609_NotifyTip( sceneId, selfId, msg )

	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )

end

--**********************************
--��NPC�Ի�
--**********************************
function x500609_TalkInfo( sceneId, selfId, targetId, msg )

	BeginEvent(sceneId)
		AddText( sceneId, msg )
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)

end

--**********************************
--ȡ�ñ��¼���MissionId������obj�ļ��жԻ��龰���ж�
--**********************************
function x500609_GetEventMissionId( sceneId, selfId )	
	return x500609_g_MissionId
end

function x500609_AcceptMission( sceneId, selfId, targetId )
	
	--�жϸ�npc�Ƿ��Ƕ�Ӧ�����npc
	if LuaFnGetName( sceneId, targetId ) ~= x500609_g_Name then
		x500609_NotifyTip( sceneId, selfId, "��������ʧ��" )
		return 0
	end

	local  PlayerName=GetName(sceneId,selfId)		
	
	--�����������ʱ��ʾ����Ϣ
	BeginEvent(sceneId)
		AddText(sceneId,x500609_g_MissionName)
		AddText( sceneId, x500609_g_MissionInfo )
		AddText(sceneId,"#{M_MUBIAO}")
		AddText(sceneId,"#{YD_20080421_63}")
		AddText(sceneId,"#{M_SHOUHUO}")
		AddMoneyBonus( sceneId, x500609_g_MoneyBonus)
		
	EndEvent( )
	DispatchMissionInfo(sceneId,selfId,targetId,x500609_g_ScriptId,x500609_g_MissionId)	

end

--/////////////////////////////////////////////////////////////////////////////////////////////////////
--��ȡ����item����ϸ��Ϣ
function x500609_GetItemDetailInfo(itemId)
	return 0
end	

--**********************************
--����ʹ��
--**********************************
function x500609_OnUseItem( sceneId, selfId, bagIndex )	
end

--**********************************
--�����¼�
--**********************************
function x500609_OnDie( sceneId, selfId, killerId )
end