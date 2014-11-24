class SeedRunners < ActiveRecord::Migration
  def up
    Runner.all.each {|r| r.update_attribute(:deleted, true)}

    runners = [{name: "Aakash More", phone: "9999999999", address: "Mahatma jyoti bai fule nagar iit marg 400076"},
    {name: "Aatish Natawate", phone: "9220150103", address: "Pitru vasalya hcs society pareravadi sakinaka mumbai 400072"},
    {name: "Amit Sawant", phone: "9773854626", address: "Jai prabhat galli no 3 ramabai ambedkar nagar ghatkopar east mum75"},
    {name: "Anil Pakhare", phone: "9167195263", address: "Indra Nagar Pipeline near kalimata mandir iit Mumbai 400076"},
    {name: "Anirudha Sawant", phone: "7666837556", address: "Room No 5 sitabai kholi chawl kajupada bhatwadi ghatkopar west"},
    {name: "Ashok", phone: "9819516635", address: "Neat s m sheety school"},
    {name: "Dashrath", phone: "8652709224", address: "Mahatma jyoti bai fule nagar iit marg 400076"},
    {name: "Dinesh Hiwale", phone: "8108864657", address: "Rahul Nagar No 2 sion chunnabhatti mumbai 400022"},
    {name: "Dinesh Redil", phone: "9987875626", address: "Janki Kirana store anand chawl commite mukund nagar p l lokhande marg chembur west mumbai 400089"},
    {name: "Mitesh Wagela", phone: "9619888202", address: "14 hansraj 029 chawal nr duraga maharani wadi road no 4 kandivali west 400067"},
    {name: "Ramesh", phone: "8422044188", address: "Aarey milk colony unit no 22 goregaon east mum 65"},
    {name: "Sandeep", phone: "8286151839", address: "Chaitanya Nagar, IIT Powai"},
    {name: "Umesh", phone: "9004954462", address: "Chaitanya Nagar, IIT Powai"}]

    runners.each do |runner_attribs|
      Runner.create!(runner_attribs)
    end

  end

  def down
  end
end
