<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/">
    <table width="95%" border="0" cellpadding="10" cellspacing="0" align="center">
      <tr>
        <td>
          <h2>Food stall Licence Application</h2>
          Thank you for your application.
        </td>
      </tr>
    </table>


    <table width="95%" border="1" cellpadding="10" cellspacing="0" align="center">
      <tr>
        <td align="right" width="50%">Application reference number</td>
        <td>
          <xsl:value-of select="root/tb_reference"/>
        </td>
      </tr>
      <tr>
        <td align="right" width="50%">Application reference</td>
        <td>
          <xsl:value-of select="root/ram_id"/>
        </td>
      </tr>
      <tr>
        <td align="right" width="50%">Name of Business / Organisation</td>
        <td>
          <xsl:value-of select="root/tb_organisationname"/>
        </td>
      </tr>
      <tr>
        <td align="right" width="50%">Specific location(s)</td>
        <td>
          <xsl:for-each select="root/locationsRepeater/locations">
            <a>
              <xsl:attribute name="href">
                <xsl:value-of select="/root/locationurl"/>
                <xsl:value-of select="locationcoords"/>
              </xsl:attribute>
              <xsl:attribute name="target">_blank</xsl:attribute>
              <xsl:value-of select="location"/>
            </a>
            <br />
          </xsl:for-each>
        </td>
      </tr>
      <tr>
        <td align="right" width="50%">If the location(s) specified are on private land, has permission been granted to you or the organisation hosting the event?</td>
        <td>
          <xsl:value-of select="root/dd_privateland"/>
        </td>
      </tr>
      <tr>
        <td align="right" width="50%">
          If the location(s) specified are on council land, has an application for "Use of Parks or Open Spaces" been made by you or the organisation hosting the event?
        </td>
        <td>
          <xsl:value-of select="root/dd_councilland"/>
        </td>
      </tr>
      <tr>
        <td align="right" width="50%">Is this a fundraiser?  If so what type of organisation are you?</td>
        <td>
          <xsl:value-of select="root/dd_fundraiser"/>
        </td>
      </tr>
      <xsl:if test="root/dd_fundraiser = 'Charitable organisation'">
        <tr>
          <td align="right" width="50%">Charity reference</td>
          <td>
            <xsl:value-of select="root/tb_charityreference"/>
          </td>
        </tr>
      </xsl:if>
      <xsl:if test="root/dd_fundraiser = 'Charitable organisation' or root/dd_fundraiser = 'Community group'">
        <tr>
          <td colspan="2" style="text-align: left">
            <p>
              A community group may run up to 20 fundraisers per year.
            </p>
            <p>
              Fundraisers are not required to provide all the detailed information for an application but we would encourage you to visit the Ministry for Primary Industries website at <a href="http://www.mpi.govt.nz" target="_blank">www.mpi.govt.nz</a> to ensure you are providing food in the safest manner possible.
            </p>
            <p>
              The information on <a href="http://www.mpi.govt.nz/dmsdocument/3714-hot-tips-for-a-safe-and-successful-sausage-sizzle" target="_blank">Sausage sizzles</a>     and <a href="http://www.mpi.govt.nz/dmsdocument/3721-food-safety-tips-for-selling-food-at-occasional-events" target="_blank">Selling food at occasional events</a> maybe particularly useful.
            </p>
          </td>
        </tr>
      </xsl:if>
      <tr>
        <td align="right" width="50%">Is this an application for specific dates only or for the whole year</td>
        <td>
          <xsl:value-of select="root/dd_FullYear"/>
        </td>
      </tr>
      <tr>
        <td align="right" width="50%">Intended date(s) of use</td>
        <td>
          <xsl:for-each select="root/datesofuseRepeater/datesofuse">
            <xsl:value-of select="dateofuse" />
            <br />
          </xsl:for-each>
        </td>
      </tr>
      <tr>
        <td align="right" width="50%">What food business registration do you hold?</td>
        <td>
          <xsl:value-of select="root/dd_registered"/>
        </td>
      </tr>
      <xsl:if test="root/dd_registered = 'Whanganui District Council'">
        <tr>
          <td align="right" width="50%">Please enter your "WGN" number</td>
          <td>
            <xsl:value-of select="root/tb_wgn"/>
          </td>
        </tr>
      </xsl:if>
      <xsl:if test="root/dd_registered = 'Another territorial authority'">
        <tr>
          <td align="right" width="50%">Please upload a copy of your current certificate</td>
          <td>
            <xsl:for-each select="root/uploaded/fu_othercouncil">
              <a>
                <xsl:attribute name="href">
                  <xsl:value-of select="url"/>
                </xsl:attribute>
                <xsl:attribute name="target">_blank</xsl:attribute>
                <xsl:value-of select="filename"/>
              </a>
              <br />
            </xsl:for-each>
          </td>
        </tr>
      </xsl:if>
      <xsl:if test="root/dd_registered = 'MPI'">
        <tr>
          <td align="right" width="50%">Please upload a copy of your current certificate</td>
          <td>
            <xsl:for-each select="root/uploaded/fu_mpi">
              <a>
                <xsl:attribute name="href">
                  <xsl:value-of select="url"/>
                </xsl:attribute>
                <xsl:attribute name="target">_blank</xsl:attribute>
                <xsl:value-of select="filename"/>
              </a>
              <br />
            </xsl:for-each>
          </td>
        </tr>
      </xsl:if>
      <tr>
        <td align="right" width="50%">Please provide details of food to be supplied</td>
        <td>
          <xsl:value-of select="root/tb_fooddetails"/>
        </td>
      </tr>
      <tr>
        <td align="right" width="50%">What facilities will be available for handwashing?</td>
        <td>
          <xsl:value-of select="root/tb_handwashing"/>
        </td>
      </tr>
      <xsl:if test="root/dd_registered = 'Not registered'">
        <tr>
          <td align="right" width="50%">How will you ensure chilled food is kept cold (Under 5°C)?</td>
          <td>
            <xsl:value-of select="root/tb_cooler"/>
          </td>
        </tr>
        <tr>
          <td align="right" width="50%">How will you ensure hot food is kept hot (above 60°C)?</td>
          <td>
            <xsl:value-of select="root/tb_warmer"/>
          </td>
        </tr>
        <tr>
          <td align="right" width="50%">How will you ensure high risk food is cooked or reheated adequately (> 75°C)?</td>
          <td>
            <xsl:value-of select="root/tb_cookedreheated"/>
          </td>
        </tr>
        <tr>
          <td align="right" width="50%">How will raw and ready to eat food be kept separate?</td>
          <td>
            <xsl:value-of select="root/tb_rawreadytoeat"/>
          </td>
        </tr>
        <tr>
          <td align="right" width="50%">Do you know what ingredients are in the food being sold?</td>
          <td>
            <xsl:value-of select="root/dd_allergens"/>
          </td>
        </tr>
        <tr>
          <td align="right" width="50%">Will all food provided be sold in a pre-packages/wrapped form?</td>
          <td>
            <xsl:value-of select="root/dd_prepackaged"/>
          </td>
        </tr>

        <xsl:if test="root/dd_prepackaged = 'No'">
          <tr>
            <td align="right" width="50%">How will running water be provided for hand washing?</td>
            <td>
              <xsl:value-of select="root/tb_water"/>
            </td>
          </tr>
          <tr>
            <td align="right" width="50%">Please confirm that pump soap will be available</td>
            <td>
              <xsl:value-of select="root/dd_pumpsoap"/>
            </td>
          </tr>
          <tr>
            <td align="right" width="50%">
              What will you provide to dry hands with?
            </td>
            <td>
              <xsl:value-of select="root/tb_handdrying"/>
            </td>
          </tr>
          <tr>
            <td align="right" width="50%">What first aid equipment is available at the stall (or elsewhere at the site)?</td>
            <td>
              <xsl:value-of select="root/tb_firstaid"/>
            </td>
          </tr>
          <tr>
            <td align="right" width="50%">What protective clothing will food handlers wear?</td>
            <td>
              <xsl:value-of select="root/tb_protectiveclothing"/>
            </td>
          </tr>
          <tr>
            <td align="right" width="50%">What facilities will be available to wash utensils and equipment?</td>
            <td>
              <xsl:value-of select="root/tb_utensilwashing"/>
            </td>
          </tr>
        </xsl:if>


        <tr>
          <td align="right" width="50%">What rubbish and waste-water disposal facilities will be available?</td>
          <td>
            <xsl:value-of select="root/tb_rubbish"/>
          </td>
        </tr>
      </xsl:if>
      <tr>
        <td align="right" width="50%">General information</td>
        <td>
          <xsl:value-of select="root/tb_generalinformation"/>
        </td>
      </tr>
      <tr>
        <td align="right" width="50%">
          Please confirm that you are aware that nobody that has had vomiting or diarrhoea upto 48 hours prior to the event will help with food
        </td>
        <td>
          <xsl:value-of select="root/dd_sick"/>
        </td>
      </tr>
      <tr>
        <td align="right" width="50%">Please confirm that you will take all necessary steps to ensure safe food</td>
        <td>
          <xsl:value-of select="root/dd_confirm"/>
        </td>
      </tr>
    </table>
    <p></p>

  </xsl:template>
</xsl:stylesheet>