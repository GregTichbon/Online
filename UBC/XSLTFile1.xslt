<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/">

    <xsl:value-of select="root/firstname"/>

    <xsl:variable name="myVariable1">
      <xsl:call-template name="test">
        <xsl:with-param name="p1" select="root/firstname" />
      </xsl:call-template>
    </xsl:variable>

    <xsl:value-of select="$myVariable1" />

    <xsl:variable name="myVariable2">
      <xsl:call-template name="string-replace-all">
        <xsl:with-param name="text" select="root/residentialaddress"/>
        <xsl:with-param name="replace" select="'a'"/>
        <xsl:with-param name="by" select="'X'"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:value-of select="$myVariable2" />


    <xsl:variable name="myVariable3">
      <xsl:call-template name="break">
        <xsl:with-param name="text" select="root/residentialaddress"/>

      </xsl:call-template>
    </xsl:variable>

    <xsl:value-of select="$myVariable3" />


  </xsl:template>



  <xsl:template name="test">
    <xsl:param name="p1" />

    <!--<xsl:text>A function that does something</xsl:text>-->
    <xsl:value-of select="$p1" />
  </xsl:template>

  
  
  
  
  
  
  
  <xsl:template name="string-replace-all">
    <xsl:param name="text" />
    <xsl:param name="replace" />
    <xsl:param name="by" />


    
    <xsl:choose>
      <xsl:when test="contains($text, $replace)">
        <xsl:value-of select="substring-before($text,$replace)" />
        <xsl:value-of select="$by" />
        <xsl:call-template name="string-replace-all">
          <xsl:with-param name="text" select="substring-after($text,$replace)" />
          <xsl:with-param name="replace" select="$replace" />
          <xsl:with-param name="by" select="$by" />
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$text" />
      </xsl:otherwise>
    </xsl:choose>

  </xsl:template>


  <xsl:template name="break">
    <xsl:param name="text" select="string(.)"/>
    <xsl:choose>
      <xsl:when test="contains($text, '&#xa;')">
        <xsl:value-of select="substring-before($text, '&#xa;')"/>
        <br/>
        <xsl:call-template name="break">
          <xsl:with-param
            name="text"
            select="substring-after($text, '&#xa;')"
        />
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$text"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>

