/****************************************************************************
*
*                          PUBLIC DOMAIN NOTICE                         
*         Lister Hill National Center for Biomedical Communications
*                      National Library of Medicine
*                      National Institues of Health
*           United States Department of Health and Human Services
*                                                                         
*  This software is a United States Government Work under the terms of the
*  United States Copyright Act. It was written as part of the authors'
*  official duties as United States Government employees and contractors
*  and thus cannot be copyrighted. This software is freely available
*  to the public for use. The National Library of Medicine and the
*  United States Government have not placed any restriction on its
*  use or reproduction.
*                                                                        
*  Although all reasonable efforts have been taken to ensure the accuracy 
*  and reliability of the software and data, the National Library of Medicine
*  and the United States Government do not and cannot warrant the performance
*  or results that may be obtained by using this software or data.
*  The National Library of Medicine and the U.S. Government disclaim all
*  warranties, expressed or implied, including warranties of performance,
*  merchantability or fitness for any particular purpose.
*                                                                         
*  For full details, please see the MetaMap Terms & Conditions, available at
*  http://metamap.nlm.nih.gov/MMTnCs.shtml.
*
***************************************************************************/

% negex triggers called by negex.pl

:- module(negex_triggers,  [
	nega_phrase_tokens/2,
	negb_phrase_tokens/2,
	pnega_phrase_tokens/2,
	pnegb_phrase_tokens/2,
	pseudoneg_phrase_tokens/2,
	conj_phrase_tokens/2
   ]).

%
% List of negation triggers.
%

% In http://code.google.com/p/negex/wiki/NegExTerms,
% these are "Pre-condition negation terms (used to mark an indexed term as negated)".

nega_phrase_tokens(absence, [of]).
nega_phrase_tokens(cannot, []).
nega_phrase_tokens(cannot, [see]).
nega_phrase_tokens(checked, [for]).
nega_phrase_tokens(declined, []).
nega_phrase_tokens(declines, []).
nega_phrase_tokens(deny, []).
nega_phrase_tokens(denied, []).
nega_phrase_tokens(denies, []).
nega_phrase_tokens(denying, []).
nega_phrase_tokens(evaluate, [for]).
nega_phrase_tokens(fails, [to,reveal]).
nega_phrase_tokens(free, [of]).
nega_phrase_tokens(negative, [for]).
nega_phrase_tokens(never, [developed]).
nega_phrase_tokens(never, [had]).
nega_phrase_tokens(no, []).
nega_phrase_tokens(no, [abnormal]).
nega_phrase_tokens(no, [cause,of]).
nega_phrase_tokens(no, [complaints,of]).
nega_phrase_tokens(no, [evidence]).
nega_phrase_tokens(no, [new,evidence]).
nega_phrase_tokens(no, [other,evidence]).
nega_phrase_tokens(no, [evidence,to,suggest]).
nega_phrase_tokens(no, [findings,of]).
nega_phrase_tokens(no, [findings,to,indicate]).
nega_phrase_tokens(no, [mammographic,evidence,of]).
nega_phrase_tokens(no, [new]).
nega_phrase_tokens(no, [radiographic,evidence,of]).
nega_phrase_tokens(no, [sign,of]).
nega_phrase_tokens(no, [significant]).
nega_phrase_tokens(no, [signs,of]).
nega_phrase_tokens(no, [suggestion,of]).
nega_phrase_tokens(no, [suspicious]).
nega_phrase_tokens(non, []).
nega_phrase_tokens(not, []).
nega_phrase_tokens(not, [appear]).
nega_phrase_tokens(not, [appreciate]).
nega_phrase_tokens(not, [associated,with]).
nega_phrase_tokens(not, [complain,of]).
nega_phrase_tokens(not, [demonstrate]).
nega_phrase_tokens(not, [exhibit]).
nega_phrase_tokens(not, [feel]).
nega_phrase_tokens(not, [had]).
nega_phrase_tokens(not, [have]).
nega_phrase_tokens(not, [know,of]).
nega_phrase_tokens(not, [known,to,have]).
nega_phrase_tokens(not, [reveal]).
nega_phrase_tokens(not, [see]).
nega_phrase_tokens(not, [to,be]).
nega_phrase_tokens(patient, [was,not]).
nega_phrase_tokens(rather, [than]).
nega_phrase_tokens(resolved, []).
nega_phrase_tokens(test, [for]).
nega_phrase_tokens(to, [exclude]).
nega_phrase_tokens(unremarkable, [for]).
nega_phrase_tokens(with, [no]).
nega_phrase_tokens(without, []).
nega_phrase_tokens(without, [any,evidence,of]).
nega_phrase_tokens(without, [evidence]).
nega_phrase_tokens(without, [indication,of]).
nega_phrase_tokens(without, [sign,of]).
nega_phrase_tokens(rules, [out]).
nega_phrase_tokens(rules, [him,out]).
nega_phrase_tokens(rules, [her,out]).
nega_phrase_tokens(rules, [the,patient,out]).
nega_phrase_tokens(rules, [out,for]).
nega_phrase_tokens(rules, [him,out,for]).
nega_phrase_tokens(rules, [her,out,for]).
nega_phrase_tokens(rules, [the,patient,out,for]).
nega_phrase_tokens(ruled, [out]).
nega_phrase_tokens(ruled, [him,out]).
nega_phrase_tokens(ruled, [her,out]).
nega_phrase_tokens(ruled, [the,patient,out]).
nega_phrase_tokens(ruled, [out,for]).
nega_phrase_tokens(ruled, [him,out,for]).
nega_phrase_tokens(ruled, [her,out,for]).
nega_phrase_tokens(ruled, [the,patient,out,for]).
nega_phrase_tokens(ruled, [out,against]).
nega_phrase_tokens(ruled, [him,out,against]).
nega_phrase_tokens(ruled, [her,out,against]).
nega_phrase_tokens(ruled, [the,patient,out,against]).
nega_phrase_tokens(did, [rule,out]).
nega_phrase_tokens(did, [rule,out,for]).
nega_phrase_tokens(did, [rule,out,against]).
nega_phrase_tokens(did, [rule,him,out]).
nega_phrase_tokens(did, [rule,her,out]).
nega_phrase_tokens(did, [rule,the,patient,out]).
nega_phrase_tokens(did, [rule,him,out,for]).
nega_phrase_tokens(did, [rule,her,out,for]).
nega_phrase_tokens(did, [rule,him,out,against]).
nega_phrase_tokens(did, [rule,her,out,against]).
nega_phrase_tokens(did, [rule,the,patient,out,for]).
nega_phrase_tokens(did, [rule,the,patient,out,against]).
nega_phrase_tokens(can, [rule,out]).
nega_phrase_tokens(can, [rule,out,for]).
nega_phrase_tokens(can, [rule,out,against]).
nega_phrase_tokens(can, [rule,him,out]).
nega_phrase_tokens(can, [rule,her,out]).
nega_phrase_tokens(can, [rule,the,patient,out]).
nega_phrase_tokens(can, [rule,him,out,for]).
nega_phrase_tokens(can, [rule,her,out,for]).
nega_phrase_tokens(can, [rule,the,patient,out,for]).
nega_phrase_tokens(can, [rule,him,out,against]).
nega_phrase_tokens(can, [rule,her,out,against]).
nega_phrase_tokens(can, [rule,the,patient,out,against]).
nega_phrase_tokens(adequate, [to,rule,out]).
nega_phrase_tokens(adequate, [to,rule,him,out]).
nega_phrase_tokens(adequate, [to,rule,her,out]).
nega_phrase_tokens(adequate, [to,rule,the,patient,out]).
nega_phrase_tokens(adequate, [to,rule,out,for]).
nega_phrase_tokens(adequate, [to,rule,him,out,for]).
nega_phrase_tokens(adequate, [to,rule,her,out,for]).
nega_phrase_tokens(adequate, [to,rule,the,patient,out,for]).
nega_phrase_tokens(adequate, [to,rule,the,patient,out,against]).
nega_phrase_tokens(sufficient, [to,rule,out]).
nega_phrase_tokens(sufficient, [to,rule,him,out]).
nega_phrase_tokens(sufficient, [to,rule,her,out]).
nega_phrase_tokens(sufficient, [to,rule,the,patient,out]).
nega_phrase_tokens(sufficient, [to,rule,out,for]).
nega_phrase_tokens(sufficient, [to,rule,him,out,for]).
nega_phrase_tokens(sufficient, [to,rule,her,out,for]).
nega_phrase_tokens(sufficient, [to,rule,the,patient,out,for]).
nega_phrase_tokens(sufficient, [to,rule,out,against]).
nega_phrase_tokens(sufficient, [to,rule,him,out,against]).
nega_phrase_tokens(sufficient, [to,rule,her,out,against]).
nega_phrase_tokens(sufficient, [to,rule,the,patient,out,against]).
% The following nega_phrase_token was added by NLM
nega_phrase_tokens(with, [no,evidence,of]).

% In http://code.google.com/p/negex/wiki/NegExTerms,
% these are "Post-condition negation terms".

negb_phrase_tokens(unlikely, []).
negb_phrase_tokens(free, []).
negb_phrase_tokens(was, [ruled,out]).
negb_phrase_tokens(is, [ruled,out]).
negb_phrase_tokens(are, [ruled,out]).
negb_phrase_tokens(have, [been,ruled,out]).
negb_phrase_tokens(has, [been,ruled,out]).
negb_phrase_tokens(is,[negative]).
negb_phrase_tokens(are,[negative]).
negb_phrase_tokens(was,[negative]).
negb_phrase_tokens(were,[negative]).

% In http://code.google.com/p/negex/wiki/NegExTerms,
% these are "Pre-condition possibility phrase (used to mark an indexed term as possible)".

pnega_phrase_tokens(rule, [out]).
pnega_phrase_tokens('r/o', []).
pnega_phrase_tokens(ro, []).
pnega_phrase_tokens(rule, [him,out]).
pnega_phrase_tokens(rule, [her,out]).
pnega_phrase_tokens(rule, [the,patient,out]).
pnega_phrase_tokens(rule, [out,for]).
pnega_phrase_tokens(rule, [him,out,for]).
pnega_phrase_tokens(rule, [her,out,for]).
pnega_phrase_tokens(rule, [the,patient,out,for]).
pnega_phrase_tokens(be, [ruled,out,for]).
pnega_phrase_tokens(should, [be,ruled,out,for]).
pnega_phrase_tokens(ought, [to,be,ruled,out,for]).
pnega_phrase_tokens(may, [be,ruled,out,for]).
pnega_phrase_tokens(might, [be,ruled,out,for]).
pnega_phrase_tokens(could, [be,ruled,out,for]).
pnega_phrase_tokens(will, [be,ruled,out,for]).
pnega_phrase_tokens(can, [be,ruled,out,for]).
pnega_phrase_tokens(must, [be,ruled,out,for]).
pnega_phrase_tokens(is, [to,be,ruled,out,for]).
pnega_phrase_tokens(what, [must,be,ruled,out,is]).

% In http://code.google.com/p/negex/wiki/NegExTerms,
% these are "Post-condition possibility terms (used to mark an indexed term as possible)".

pnegb_phrase_tokens(did, [not,rule,out]).
pnegb_phrase_tokens(not, [ruled,out]).
pnegb_phrase_tokens(not, [been,ruled,out]).
pnegb_phrase_tokens(being, [ruled,out]).
pnegb_phrase_tokens(be, [ruled,out]).
pnegb_phrase_tokens(should, [be,ruled,out]).
pnegb_phrase_tokens(ought, [to,be,ruled,out]).
pnegb_phrase_tokens(may, [be,ruled,out]).
pnegb_phrase_tokens(might, [be,ruled,out]).
pnegb_phrase_tokens(could, [be,ruled,out]).
pnegb_phrase_tokens(will, [be,ruled,out]).
pnegb_phrase_tokens(can, [be,ruled,out]).
pnegb_phrase_tokens(must, [be,ruled,out]).
pnegb_phrase_tokens(is, [to,be,ruled,out]).

% In http://code.google.com/p/negex/wiki/NegExTerms,
% these are "Pseudo negation terms".

pseudoneg_phrase_tokens(no,	 [increase]).
pseudoneg_phrase_tokens(no,      [suspicious,change]).
pseudoneg_phrase_tokens(no,      [significant,change]).
pseudoneg_phrase_tokens(no,      [change]).
pseudoneg_phrase_tokens(no,      [interval,change]).
pseudoneg_phrase_tokens(no,      [definite,change]).
pseudoneg_phrase_tokens(no,      [significant,interval,change]).
pseudoneg_phrase_tokens(not,     [extend]).
pseudoneg_phrase_tokens(not,     [cause]).
pseudoneg_phrase_tokens(not,     [drain]).
pseudoneg_phrase_tokens(not,     [certain,if]).
pseudoneg_phrase_tokens(not,     [certain,whether]).
pseudoneg_phrase_tokens(gram,    [negative]).
pseudoneg_phrase_tokens(without, [difficulty]).
pseudoneg_phrase_tokens(not,     [necessarily]).
pseudoneg_phrase_tokens(not,     [only]).

% In http://code.google.com/p/negex/wiki/NegExTerms,
% these are "Termination terms".

conj_phrase_tokens(although, []).
conj_phrase_tokens(apart, [from]).
conj_phrase_tokens(as, [a,cause,for]).
conj_phrase_tokens(as, [a,cause,of]).
conj_phrase_tokens(as, [a,etiology,for]).
conj_phrase_tokens(as, [a,etiology,of]).
conj_phrase_tokens(as, [a,reason,for]).
conj_phrase_tokens(as, [a,reason,of]).
conj_phrase_tokens(as, [a,secondary,cause,for]).
conj_phrase_tokens(as, [a,secondary,cause,of]).
conj_phrase_tokens(as, [a,secondary,etiology,for]).
conj_phrase_tokens(as, [a,secondary,etiology,of]).
conj_phrase_tokens(as, [a,secondary,origin,for]).
conj_phrase_tokens(as, [a,secondary,origin,of]).
conj_phrase_tokens(as, [a,secondary,reason,for]).
conj_phrase_tokens(as, [a,secondary,reason,of]).
conj_phrase_tokens(as, [a,secondary,source,for]).
conj_phrase_tokens(as, [a,secondary,source,of]).
conj_phrase_tokens(as, [a,source,for]).
conj_phrase_tokens(as, [a,source,of]).
conj_phrase_tokens(as, [an,cause,for]).
conj_phrase_tokens(as, [an,cause,of]).
conj_phrase_tokens(as, [an,etiology,for]).
conj_phrase_tokens(as, [an,etiology,of]).
conj_phrase_tokens(as, [an,origin,for]).
conj_phrase_tokens(as, [an,origin,of]).
conj_phrase_tokens(as, [an,reason,for]).
conj_phrase_tokens(as, [an,reason,of]).
conj_phrase_tokens(as, [an,secondary,cause,for]).
conj_phrase_tokens(as, [an,secondary,cause,of]).
conj_phrase_tokens(as, [an,secondary,etiology,for]).
conj_phrase_tokens(as, [an,secondary,etiology,of]).
conj_phrase_tokens(as, [an,secondary,origin,for]).
conj_phrase_tokens(as, [an,secondary,origin,of]).
conj_phrase_tokens(as, [an,secondary,reason,for]).
conj_phrase_tokens(as, [an,secondary,reason,of]).
conj_phrase_tokens(as, [an,secondary,source,for]).
conj_phrase_tokens(as, [an,secondary,source,of]).
conj_phrase_tokens(as, [an,source,for]).
conj_phrase_tokens(as, [an,source,of]).
conj_phrase_tokens(as, [the,cause,for]).
conj_phrase_tokens(as, [the,cause,of]).
conj_phrase_tokens(as, [the,etiology,for]).
conj_phrase_tokens(as, [the,etiology,of]).
conj_phrase_tokens(as, [the,origin,for]).
conj_phrase_tokens(as, [the,origin,of]).
conj_phrase_tokens(as, [the,reason,for]).
conj_phrase_tokens(as, [the,reason,of]).
conj_phrase_tokens(as, [the,secondary,cause,for]).
conj_phrase_tokens(as, [the,secondary,cause,of]).
conj_phrase_tokens(as, [the,secondary,etiology,for]).
conj_phrase_tokens(as, [the,secondary,etiology,of]).
conj_phrase_tokens(as, [the,secondary,origin,for]).
conj_phrase_tokens(as, [the,secondary,origin,of]).
conj_phrase_tokens(as, [the,secondary,reason,for]).
conj_phrase_tokens(as, [the,secondary,reason,of]).
conj_phrase_tokens(as, [the,secondary,source,for]).
conj_phrase_tokens(as, [the,secondary,source,of]).
conj_phrase_tokens(as, [the,source,for]).
conj_phrase_tokens(as, [the,source,of]).
conj_phrase_tokens(aside, [from]).
conj_phrase_tokens(but, []).
conj_phrase_tokens(cause, [for]).
conj_phrase_tokens(cause, [of]).
conj_phrase_tokens(causes, [for]).
conj_phrase_tokens(causes, [of]).
conj_phrase_tokens(etiology, [for]).
conj_phrase_tokens(etiology, [of]).
conj_phrase_tokens(except, []).
conj_phrase_tokens(however, []).
conj_phrase_tokens(nevertheless, []).
conj_phrase_tokens(origin, [for]).
conj_phrase_tokens(origin, [of]).
conj_phrase_tokens(origins, [for]).
conj_phrase_tokens(origins, [of]).
conj_phrase_tokens(other, [possibilities,of]).
conj_phrase_tokens(reason, [for]).
conj_phrase_tokens(reason, [of]).
conj_phrase_tokens(reasons, [for]).
conj_phrase_tokens(reasons, [of]).
conj_phrase_tokens(secondary, [to]).
conj_phrase_tokens(source, [for]).
conj_phrase_tokens(source, [of]).
conj_phrase_tokens(sources, [for]).
conj_phrase_tokens(sources, [of]).
conj_phrase_tokens(still, []).
conj_phrase_tokens(though, []).
conj_phrase_tokens(trigger, [event,for]).
conj_phrase_tokens(yet, []).

% The following conj_phrase_tokens were added by NLM
conj_phrase_tokens(other,     [than]).
conj_phrase_tokens(otherwise, []).
conj_phrase_tokens(then,      []).
conj_phrase_tokens(to,        [account,for]).
conj_phrase_tokens(to,        [explain]).

% Negated UMLS concepts must below to one of the following semantic types
% this is essentially a specially defined semantic group that is a super set of "Disorders"
% negex_semtype_list([acab,anab,biof,cgab,comd,dsyn,emod,fndg,
%		      inpo,lbtr,menp,mobd,neop,patf,phsf,sosy]).

% fin

% :- use_module(library(addportray)).
% portray_mm_output(mm_output(_ExpandedUtterance,_CitationTextAtom,_ModifiedText,_Tagging,_AAs,
% 			    _Syntax,_DisambiguatedMMOPhrases,_ExtractedPhrases)) :- write('MMO').
% :- add_portray(portray_mm_output).
