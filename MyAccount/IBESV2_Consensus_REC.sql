/*
      I/B/E/S V2 RECOMMENDATION SUMMARY
      --------------------------------------------
      THIS QUERY RETURNS I/B/E/S CONSENSUS RECOMMENDATION DATA.



      
      MAINTENANCE LOG
      DATE              DEVELOPER               ACTION            NOTES
      ------------------------------------------------------------------------------
      06/2015           SANDEEP  SUBASH         CREATED
      02/2016			SANDEEP  SUBASH			MODIFIED		INCLUDED THE USE OF VW_SECURITYMASTERX AND VW_IBES2MAPPING

      SECURITYMASTER AND IBES2MAPPING VIEWS NEEDED TO BE INSTALLED TO RUN THIS SCRIPT.    
         


*/
DECLARE @ID AS VARCHAR(10)	
SET @ID = '@TOYOT17'				

SELECT S.ID
	,I.ESTPERMID
	,I.IBESTICKER
	,S.NAME
	,REC.EFFECTIVEDATE
	,REC.EXPIREDATE
	,REC.ISREALTIME
	,REC.MEANREC AS MEAN
	,C.DESCRIPTION AS RECOMM_TEXT 
	,REC.MEDIANREC
	,REC.LOWREC AS LOWESTREC
	,REC.HIGHREC AS HIGHESTREC
	,REC.NUMRECS AS NUM_RECS_IN_MEAN
	
FROM VW_SECURITYMASTERX S   --SECURITYMASTER VIEWS

JOIN VW_IBES2MAPPING M      --IBESV2 MAPPING VIEWS   
	ON S.SECCODE = M.SECCODE 
	AND M.TYP = S.TYP

JOIN TREINFO I 
	 ON I.ESTPERMID = M.ESTPERMID
	
JOIN TRERECSUM REC       --RETURNS THE CONSENSUS RECOMMENDATIONS.
	ON REC.ESTPERMID = I.ESTPERMID 
	
JOIN TRECODE C 
	ON C.CODETYPE = 26 -- RECOMMENDATION DESC
	AND C.CODE = REC.MEANREC	
	
WHERE S.ID = @ID  
ORDER BY EFFECTIVEDATE



















