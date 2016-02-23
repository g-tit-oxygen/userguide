<?xml version="1.0" encoding="UTF-8"?>
<!--
        Do not edit this file directly!
        This file is generated automatically by processing 
        info-model.ditamap
        If you want to change the rules, edit the corresponding sections 
        marked with audience="rules" in the corresponding topic files.
      -->
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron"
  xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  queryBinding="xslt2">
   <sch:include href="library.sch#avoidWordInElement"/>
   <sch:include href="library.sch#avoidEndFragment"/>
   <sch:include href="library.sch#avoidAttributeInElement"/>
   <sch:include href="library.sch#recommendElementInParent"/>
   <sch:include href="library.sch#restrictWords"/>
   <!--Generated from topics/indexEntries.dita-->
   <sch:pattern is-a="avoidWordInElement">
      <sch:param name="word" value="oXygen"/>
      <sch:param name="element" value="indexterm"/>
      <sch:param name="message" value="We should avoid using oXygen inside index terms!"/>
   </sch:pattern>
   <!--Generated from topics/images.dita-->
   <sch:pattern is-a="avoidAttributeInElement">
      <sch:param name="element" value="image"/>
      <sch:param name="attribute" value="scale"/>
      <sch:param name="message"
             value="Dynamically scaled images are not properly displayed, you&#xA;            should scale the image with an image tool and keep it within&#xA;            the recommended with and height limits."/>
   </sch:pattern>
   <!--Generated from topics/lists.dita-->
   <sch:pattern is-a="avoidEndFragment">
      <sch:param name="fragment" value=";"/>
      <sch:param name="element" value="li"/>
      <sch:param name="message"
             value="List items should not end with a semi-column (;). If it is&#xA;            a sentence then end it with a full stop (.), otherwise leave&#xA;            it without an ending character."/>
   </sch:pattern>
  
  <!-- Check the the indexterm exist. -->
  <sch:pattern>
    <sch:rule context="/*">
      <sch:assert test="prolog/metadata/keywords/indexterm" role="warn" sqf:fix="addFragment">
        It is recommended to add an 'indexterm' in the current '<sch:name/>' element.
      </sch:assert>
      
      <sqf:fix id="addFragment">
        <sqf:description>
          <sqf:title>Add the 'indexterm' element</sqf:title>
        </sqf:description>
        
        <!-- Add the indexterm element element and its parents -->
        <sqf:add match="(title | titlealts | abstract | shortdesc)[last()]" position="after" use-when="not(prolog)">
          <xsl:text>
          </xsl:text><prolog><xsl:text>
            </xsl:text><metadata><xsl:text>
              </xsl:text><keywords><xsl:text>
                 </xsl:text><indexterm><xsl:text> </xsl:text> </indexterm><xsl:text>
              </xsl:text></keywords><xsl:text>
            </xsl:text></metadata><xsl:text>
          </xsl:text></prolog>
        </sqf:add>
      </sqf:fix>
    </sch:rule>
  </sch:pattern>
  <!-- Topic ID must be equal to file name -->
  <sch:pattern>
    <sch:rule context="/*[1][contains(@class, ' topic/topic ')]">
      <sch:let name="reqId" value="replace(tokenize(document-uri(/), '/')[last()], '\.dita', '')"/>
      <sch:assert test="@id = $reqId" sqf:fix="setId">
        Topic ID must be equal to file name.
      </sch:assert>
      <sqf:fix id="setId">
        <sqf:description>
          <sqf:title>Set "<sch:value-of select="$reqId"/>" as a topic ID</sqf:title>
          <sqf:p>The topic ID must be equal to the file name.</sqf:p>
        </sqf:description>
        <sqf:replace match="@id" node-type="attribute" target="id" select="$reqId"/>
      </sqf:fix>
    </sch:rule>
  </sch:pattern>
  
  <!-- Report if link text same as @href value -->
  <sch:pattern>
    <sch:rule context="*[contains(@class, ' topic/xref ') or contains(@class, ' topic/link ')]">
      <sch:report test="@scope='external' and @href=text()" sqf:fix="removeText">
        Link text is same as @href attribute value. Please remove.
      </sch:report>
      <sqf:fix id="removeText">
        <sqf:description>
          <sqf:title>Remove redundant link text, text is same as @href value.</sqf:title>
        </sqf:description>
        <sqf:delete match="text()"/>
      </sqf:fix>
    </sch:rule>
  </sch:pattern>
  
  <sch:pattern>
    <!-- Image without any kind of reference -->
    <sch:rule context="*[contains(@class, ' topic/image ')]">
      <sch:report test="not(@href) and not(@keyref) and not(@conref) and not(@conkeyref)" sqf:fix="add_href add_keyref add_conref add_conkeyref"> Image without
        a reference. </sch:report>
      
      <sqf:fix id="add_href">
        <sqf:description>
          <sqf:title>Add @href attribute</sqf:title>
        </sqf:description>
        <sqf:add node-type="attribute" target="href"/>
      </sqf:fix>
      
      <sqf:fix id="add_keyref">
        <sqf:description>
          <sqf:title>Add @keyref attribute</sqf:title>
        </sqf:description>
        <sqf:add node-type="attribute" target="keyref"/>
      </sqf:fix>
      
      <sqf:fix id="add_conref">
        <sqf:description>
          <sqf:title>Add @conref attribute</sqf:title>
        </sqf:description>
        <sqf:add node-type="attribute" target="conref"/>
      </sqf:fix>
      
      <sqf:fix id="add_conkeyref">
        <sqf:description>
          <sqf:title>Add @conkeyref attribute</sqf:title>
        </sqf:description>
        <sqf:add node-type="attribute" target="conkeyref"/>
      </sqf:fix>
    </sch:rule>
  </sch:pattern>
 
  <sch:pattern>
    <!-- Report ul after ul -->
    <sch:rule context="*[contains(@class, ' topic/ul ')]">
      <sch:report test="following-sibling::node()[1][contains(@class, ' topic/ul ')]" role="warn" sqf:fix="mergeLists"> Two
        consecutive unordered lists. You can probably merge them into one. </sch:report>
    </sch:rule>
  </sch:pattern>

  <sch:pattern>
    <!-- Report dl after dl -->
    <sch:rule context="*[contains(@class, ' topic/dl ')]">
      <sch:report test="following-sibling::node()[1][contains(@class, ' topic/dl ')]" role="warn" sqf:fix="mergeLists"> Two
        consecutive definition lists. You can probably merge them into one. </sch:report>
    </sch:rule>
  </sch:pattern>

  <sch:pattern>
    <!-- Report ol after ol -->
    <sch:rule context="*[contains(@class, ' topic/ol ')]">
      <sch:report test="following-sibling::node()[1][contains(@class, ' topic/ol ')]" role="warn" sqf:fix="mergeLists"> Two
        consecutive ordered lists. You can probably merge them into one. </sch:report>
    </sch:rule>
  </sch:pattern>
  
  <sqf:fixes>
    <!-- Merge the two lists into one -->
    <sqf:fix id="mergeLists">
      <sqf:description>
        <sqf:title>Merge lists into one</sqf:title>
      </sqf:description>
      <sqf:add position="last-child">
        <xsl:apply-templates mode="copyExceptClass" select="following-sibling::node()[1]/node()"/>
      </sqf:add>
      <sqf:delete match="following-sibling::node()[1]"/>
    </sqf:fix>
  </sqf:fixes>
  
  <sch:pattern>
    <!-- Report possible case in which a codeblock containg XML was not marked appropriately. -->
    <sch:rule context="*[contains(@class, ' pr-d/codeblock ')]" role="warn">
      <sch:report test="starts-with(text()[1], '&lt;') and not(@outputclass)" sqf:fix="add_outputclass"> Possible XML Codeblock
        without @outputclass set to it. </sch:report>
      
      <sqf:fix id="add_outputclass">
        <sqf:description>
          <sqf:title>Add @outputclass attribute to codeblock</sqf:title>
        </sqf:description>
        <sqf:add node-type="attribute" target="outputclass"></sqf:add>
      </sqf:fix>
    </sch:rule>
  </sch:pattern>
  
  <sch:pattern>
    <!-- Report two consecutive note elements -->
    <sch:rule context="*[contains(@class, ' topic/note ')]">
      <sch:report test="preceding-sibling::element()[1][contains(@class, ' topic/note ')] and 
        @type=preceding-sibling::element()[1]/@type" role="warn" sqf:fix="changeType changeTypePrev"> Try to avoid inserting two consecutive notes with the same type. </sch:report>
      <sqf:fix id="changeType">
        <sqf:description>
          <sqf:title>Change current note type</sqf:title>
        </sqf:description>
        <sqf:delete match="@type" use-when="@type"/>
        <sqf:add node-type="attribute" target="type"/>
      </sqf:fix>
      <sqf:fix id="changeTypePrev">
        <sqf:description>
          <sqf:title>Change previous note type</sqf:title>
        </sqf:description>
        <sqf:delete match="preceding-sibling::element()[1]/@type" use-when="@type"/>
        <sqf:add match="preceding-sibling::element()[1]" node-type="attribute" target="type"/>
      </sqf:fix>
    </sch:rule>
  </sch:pattern>
  
  <sch:pattern>
    <!-- Most DITA elements should not be empty -->
    <sch:rule
      context="
      *[not(contains(@class, ' topic/image '))]
      [not(contains(@class, ' topic/colspec '))]
      [not(contains(@class, ' map/topicref '))]
      [not(contains(@class, ' topic/data '))]
      [not(contains(@class, ' topic/vrm '))]
      [not(contains(@class, ' topic/entry '))]
      [not(contains(@class, ' topic/stentry '))]
      [not(@conref)]
      [not(@conkeyref)]
      [not(@keyref)]
      [not(@href)]
      [not(ancestor::*[@conref or @conkeyref])]">
      <sch:report test="not(node())"> Empty element. </sch:report>
    </sch:rule>
  </sch:pattern>
  <sch:pattern>
    <!--Tables with more entries than number of columns -->
    <sch:rule context="*[contains(@class, ' topic/tgroup ')]">
      <sch:assert
        test="max(.//*[contains(@class, ' topic/row ')]/count(*[contains(@class, ' topic/entry ')])) = @cols"
        > Maximum number of entries must equal cols attribute specified on table. </sch:assert>
    </sch:rule>
  </sch:pattern>
  
  <!-- Add Ids to all sections, in this way you can easly refer the section from documentation -->
  <sch:pattern>
    <sch:rule context="*[contains(@class, ' topic/section ') and not(contains(@class, ' task/context ')) and not(contains(@class, ' task/result '))]">
      <sch:assert test="@id" sqf:fix="addId addIds" role="warn">All sections must have an @id attribute</sch:assert>
      
      <sqf:fix id="addId">
        <sqf:description>
          <sqf:title>Add @id to the current section</sqf:title>
          <sqf:p>Add an @id attribute to the current section. The ID is generated from the section title.</sqf:p>
        </sqf:description>
        <!-- Generate an id based on the section title. If there is no title then generate a random id. -->
        <sqf:add target="id" node-type="attribute"
          select="if (title) 
                    then substring(lower-case(replace(replace(normalize-space(string(title)), '\s', '_'), '[^a-zA-Z0-9_]', '')), 0, 50) 
                    else generate-id()"/>
      </sqf:fix>
      
      <sqf:fix id="addIds">
        <sqf:description>
          <sqf:title>Add @id to all sections</sqf:title>
          <sqf:p>Add an @id attribute to each section from the document. The ID is generated from the section title.</sqf:p>
        </sqf:description>
        <!-- Generate an id based on the section title. If there is no title then generate a random id. -->
        <sqf:add match="//section[not(@id)]" target="id" node-type="attribute" 
          select="if (title) 
                    then substring(lower-case(replace(replace(normalize-space(string(title)), '\s', '_'), '[^a-zA-Z0-9_]', '')), 0, 50) 
                    else generate-id()"/>
      </sqf:fix>
    </sch:rule>
  </sch:pattern>
  
  <!-- The titles should not be longer than 55 characters. -->
  <sch:pattern>
    <sch:rule context="*[contains(@class, ' topic/title ')]" role="warn">
      <sch:assert test="string-length(string(.)) lt 56">The title is too long. It should be less than 55 characters.</sch:assert>
    </sch:rule>
  </sch:pattern>
  
  <!-- Template used to copy the current node -->
  <xsl:template match="node() | @*" mode="copyExceptClass">
    <xsl:copy copy-namespaces="no">
      <xsl:apply-templates select="node() | @*" mode="copyExceptClass"/>
    </xsl:copy>
  </xsl:template>
  <!-- Template used to skip the @class attribute from being copied -->
  <xsl:template match="@class" mode="copyExceptClass"/>
</sch:schema>
