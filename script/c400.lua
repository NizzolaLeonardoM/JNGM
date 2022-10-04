--Pelle scelgo te!
function c400.initial_effect(c)
--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,400+EFFECT_COUNT_CODE_OATH)
	e1:SetCost(c400.cost)
	e1:SetTarget(c400.target)
	e1:SetOperation(c400.activate)
	c:RegisterEffect(e1)
end
function c400.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToGraveAsCost,tp,LOCATION_HAND,0,1,e:GetHandler()) end
	Duel.DiscardHand(tp,Card.IsAbleToGraveAsCost,1,1,REASON_COST)
end
function c400.filter(c)
	return c:IsType(TYPE_MONSTER) and (c:IsCode(401) or c:IsSetCard(0x8f)) and c:IsAbleToHand()
end
function c400.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c400.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c400.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c400.filter,tp,LOCATION_DECK,0,nil)
	if g:GetCount()==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g1=g:Select(tp,1,1,nil)
	local t={0x54,0x59,0x82,0x8f}
	for i=1,4 do
		if g1:GetFirst():IsSetCard(t[i]) then g:Remove(Card.IsSetCard,nil,t[i]) end
	end
	if g:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(400,0)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local g2=g:Select(tp,1,1,nil)
		g1:Merge(g2)
	end
	Duel.SendtoHand(g1,nil,REASON_EFFECT)
	Duel.ConfirmCards(1-tp,g1)
end
