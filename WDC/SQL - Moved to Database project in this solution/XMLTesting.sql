DECLARE @myDoc xml  = 
'<root>
  <tb_businessname>tb_businessname</tb_businessname>
  <dd_district>No</dd_district>
  <hidden_location>2</hidden_location>
  <tb_location_2>Test1</tb_location_2>
  <hf_locationcoords_2>-39.9330677,175.04865760000007,15,-39.928447833042654,175.05074501037598,-39.92989583505136,175.05164623260498,-39.92953383742069,175.05452156066895</hf_locationcoords_2>
  <tb_location_3>Test 2</tb_location_3>
  <hf_locationcoords_3>-39.9330677,175.04865760000007,15,-39.92808582775464,175.04868507385254,-39.929402201444006,175.04671096801758,-39.92923765611717,175.05014419555664</hf_locationcoords_3>
  <dd_datetype>The whole year</dd_datetype>
  <tb_products>tb_products</tb_products>
  <tb_charityname>tb_charityname</tb_charityname>
  <tb_charityreference>tb_charityreference</tb_charityreference>
  <tb_otherinformation>tb_otherinformation</tb_otherinformation>
  <otherpremisesRepeater>
    <otherpremises>
      <otherpremisesIndex>1</otherpremisesIndex>
      <otherpremises_business>repeat_otherpremises_tb_otherpremises_business_1</otherpremises_business>
      <otherpremises_owners>repeat_otherpremises_tb_otherpremises_owners_1</otherpremises_owners>
      <otherpremises_phone>027 123456</otherpremises_phone>
      <otherpremises_permission>Yes</otherpremises_permission>
    </otherpremises>
    <otherpremises>
      <otherpremisesIndex>2</otherpremisesIndex>
      <otherpremises_business>repeat_otherpremises_tb_otherpremises_business_2</otherpremises_business>
      <otherpremises_owners>repeat_otherpremises_tb_otherpremises_owners_2</otherpremises_owners>
      <otherpremises_phone>027 123456</otherpremises_phone>
      <otherpremises_permission>Yes</otherpremises_permission>
    </otherpremises>
  </otherpremisesRepeater>
  <datesofuseRepeater>
    <datesofuse>
      <datesofuseIndex>1</datesofuseIndex>
      <datesofuse>repeat_datesofuse_tb_datesofuse_1</datesofuse>
    </datesofuse>
    <datesofuse>
      <datesofuseIndex>2</datesofuseIndex>
      <datesofuse>repeat_datesofuse_tb_datesofuse_2</datesofuse>
    </datesofuse>
  </datesofuseRepeater>
  <vehicleRepeater>
    <vehicle>
      <vehicleIndex>1</vehicleIndex>
      <vehicleregistration>repeat</vehicleregistration>
      <vehicledescription>repeat_vehicle_tb_vehicledescription_1</vehicledescription>
    </vehicle>
    <vehicle>
      <vehicleIndex>2</vehicleIndex>
      <vehicleregistration>repeat</vehicleregistration>
      <vehicledescription>repeat_vehicle_tb_vehicledescription_2</vehicledescription>
    </vehicle>
  </vehicleRepeater>
</root>'  
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  
select @myDoc.value('(/root/tb_businessname/node())[1]', 'varchar(100)' ) 

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

DECLARE @handle INT  
DECLARE @PrepareXmlStatus INT  

EXEC @PrepareXmlStatus = sp_xml_preparedocument @handle OUTPUT, @myDoc  

SELECT  *
FROM    OPENXML(@handle, '/root/otherpremisesRepeater/otherpremises', 2)  
    WITH (
    otherpremisesIndex INT,
    otherpremises_business varchar(100),
    otherpremises_owners varchar(500),
    otherpremises_phone varchar(100),
    otherpremises_permission varchar(3)
    )  
EXEC sp_xml_removedocument @handle  

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Not working
SELECT  
       Tbl.Col.value('@otherpremisesIndex', 'int')
FROM   @myDoc.nodes('root/otherpremisesRepeater/otherpremises') Tbl(Col)

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

SELECT
    STUFF(
    (SELECT 
        ',' + otherpremises.value('(otherpremises_business)[1]', 'varchar(20)')
     FROM
        @myDoc.nodes('root/otherpremisesRepeater/otherpremises') AS Node(otherpremises)
     FOR XML PATH('')
    ), 1, 1, '') as 'Column Name'
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
