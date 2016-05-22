# targetfilename ='counter.rtf'
# data = File.readlines(filename)

class GetInfo
  attr_reader :hello, :information

  def self.information
    filename = 'messages.rtf'
    information = Hash.new
    File.open(filename, 'r') do |f|   # open file for reading
      lines = f.readlines       # read into array of lines

      lines.each do |line|
        if (line.include? "contact_name") && (line.include? "address")
          line1 = line.delete('\\"')
          line1 = line1.delete('/\\"').strip
          contact_index = line1.index('contact_name')
          contact_name = line1[contact_index+13..-5]

          phone_start = line1.index('address')+8
          date_index = line1.index('date')
          phone_number = line1[phone_start..date_index-1].strip


          type_index = line1.index('type')-2
          type = line1[type_index+7]
          # date_start = line1.index('date')+5
          # date_seconds = line1[date_start..type_start]

          # readable_start = line1.index('readable_date')+14
          # readable_date = line1[readable_start..contact_index-1]

          # toa_index = line1.index('toa')-2
          # body_start = line1.index('body')+5
          # body_message = line1[body_start..toa_index]

          #ignore all unknowns and phone bots
          if contact_name != "(Unknown)" && phone_number.length > 6
            #if the hash is not yet created, create a new one for that contact name
            if information[contact_name].nil?
              # puts "MMMMM"
              # p contact_name
              #did you send a message?
              if type == "2"
                information[contact_name] = {'phone_number' => phone_number, 'received' => 0, 'sent' => 1}
                # puts "HI"
              #did you receive the message?
              elsif type == "1"
                information[contact_name] = {'phone_number' => phone_number, 'received' => 1, 'sent' => 0}
                # puts "BYE"
              end
            #if the contact already exists, update the count for sent or received
            else
              if type == "2"
                information[contact_name]['sent'] += 1
              else
                information[contact_name]['received'] += 1
              end
            end
          end
        end
      end
    end
    information.delete(information.keys.last)
    return information
  end
end
# hello = information
# p hello
