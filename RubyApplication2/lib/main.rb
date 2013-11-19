#JRuby consumo de RSS y XML

require 'java'
require 'nokogiri'
require 'open-uri'
import 'java.awt.image.BufferedImage'
import 'javax.swing.JButton'
import 'javax.swing.JFrame'
import 'javax.swing.JPanel'
import 'java.lang.System'
import 'javax.swing.JOptionPane'
import 'javax.swing.JLabel'

class Proyecto < JFrame
  
  def initialize
    @image=image
    super "Consumo de RSS"
    
    self.initUI
  end
  
  def initUI
    
    panel = JPanel.new
    self.getContentPane.add panel
    
    panel.setLayout nil 
    panel.setToolTipText "Panel Contenedor"
    
    l = JLabel.new 'Hola mundo desde JRuby'
    
    exit_button = JButton.new "Salir"
    exit_button.setBounds 400, 350, 100, 30
    exit_button.setToolTipText "Boton Salir"
    exit_button.add_action_listener do |event|
      option = JOptionPane::show_confirm_dialog( self, "Cerrar Aplicacion?\n" "Y dejar de ser feliz??", "Question", JOptionPane::YES_NO_OPTION )
      if ( option == JOptionPane::YES_OPTION )
        self.dispose
      end
    end
    
#Consumo de plantas XML
    plant_button = JButton.new "Plantas"
    plant_button.setBounds 10, 350, 100, 30
    plant_button.setToolTipText "Plantas"
    plant_button.add_action_listener do doc = Nokogiri::XML(open 'http://www.w3schools.com/xml/plant_catalog.xml')  
      doc.css('PLANT').each do |plant|
        elements = []
        plant.elements.each do |child|         
          elements << child.text
        end     
        puts elements.join(',')
      end
      puts "///////////////////////////////////////////////////////////////////"
    end
    
#Consumo de articulos Cd's XML 
    cd_button = JButton.new "Discos"
    cd_button.setBounds 100, 350, 100, 30
    cd_button.setToolTipText "Discos"
    cd_button.add_action_listener do music = Nokogiri::XML(open 'http://www.w3schools.com/xml/cd_catalog.xml')     
      music.css('CD').each do |disc|
        elements = []
        disc.elements.each do |child|         
          elements << child.text
        end     
        puts elements.join(',')
      end
      puts "//////////////////////////////////////////////////////////////////"
    end
    
#Consumo de Noticias Gizmodo RSS 
    item_button = JButton.new "Noticias"
    item_button.setBounds 190, 350, 100, 30
    item_button.setToolTipText "Noticias"
    item_button.add_action_listener do giz = Nokogiri::XML(open "http://feeds.gawker.com/esgizmodo/full?format=xml") 
      giz.css('item').each do |it|
        elements = []
        it.elements.each do |child|         
          elements << child.text
        end     
        puts elements.join(',')
      end
      puts "//////////////////////////////////////////////////////////////////"
    end
    
#Agregar botones al panel  
    panel.add exit_button
    panel.add plant_button
    panel.add cd_button
    panel.add item_button
    panel.add l
    
 #configuracion principal
    self.setDefaultCloseOperation JFrame::EXIT_ON_CLOSE
    self.setSize 500, 400
    self.setLocationRelativeTo nil
    self.setVisible true
  end
  
end
Proyecto.new


