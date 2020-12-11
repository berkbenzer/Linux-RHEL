Add Redhat 8 repo

hammer organization list

hammer product create --organization-id 3 \
  --name "CentOS 8 Linux for x86_64" \
  --description "Repositories to use with CentOS 8 Linux"

  cd /etc/pki/rpm-gpg/import/
wget https://www.centos.org/keys/RPM-GPG-KEY-CentOS-Official


hammer gpg create --organization-id 3 \
  --key "RPM-GPG-KEY-CentOS-Official" \
  --name "RPM-GPG-KEY-CentOS-8"


   hammer repository create --organization-id 3 \   --product "CentOS 8 Linux for x86_64" \   --name "CentOS 8 Base RPMS" \   --label "CentOS_8_Base_RPMS" \   --content-type "yum" \  --download-policy "on_demand" \   --gpg-key "RPM-GPG-KEY-CentOS-8" \   --url "http://centos.mirror.liquidtelecom.com/8/BaseOS/x86_64/os/" \   --mirror-on-sync "no" 


   hammer repository create --organization-id 3 \   
     --product "CentOS 8 Linux for x86_64" \   
	 --name "CentOS 8 Base RPMS" \  
	 --label "CentOS_8_Base_RPMS" \   
	 --content-type "yum" \   
	 --download-policy "on_demand" \   
     --gpg-key "RPM-GPG-KEY-CentOS-8" \   
     --url "http://centos.mirror.liquidtelecom.com/8/BaseOS/x86_64/os/" \   
     --mirror-on-sync "no" 


     hammer repository create --organization-id 3 \
   --product "CentOS 8 Linux for x86_64" \
   --name "CentOS 8 AppStream RPMS" \
   --label "CentOS_8_AppStream_RPMS" \
   --content-type "yum" \
   --download-policy "on_demand" \
   --gpg-key "RPM-GPG-KEY-CentOS-8" \
   --url "http://centos.mirror.liquidtelecom.com/8/AppStream/x86_64/os/" \
   --mirror-on-sync "no"


   hammer repository create --organization-id 3 \
  --product "CentOS 8 Linux for x86_64" \
  --name "CentOS 8 PowerTools RPMS" \
  --label "CentOS_8_PowerTools_RPMS" \
  --content-type "yum" \
  --download-policy "on_demand" \
  --gpg-key "RPM-GPG-KEY-CentOS-8" \
  --url "http://centos.mirror.liquidtelecom.com/8/PowerTools/x86_64/os/" \
  --mirror-on-sync "no"

  hammer repository create --organization-id 3 \
   --product "CentOS 8 Linux for x86_64" \
   --name "CentOS 8 centosplus RPMS" \
   --label "CentOS_8_centosplus_RPMS" \
   --content-type "yum" \
   --download-policy "on_demand" \
   --gpg-key "RPM-GPG-KEY-CentOS-8" \
   --url "http://centos.mirror.liquidtelecom.com/8/centosplus/x86_64/os/" \
   --mirror-on-sync "no"


   hammer repository create --organization-id 3 \
  --product "CentOS 8 Linux for x86_64" \
  --name "CentOS 8 extras RPMS" \
  --label "CentOS_8_extras_RPMS" \
  --content-type "yum" \
  --download-policy "on_demand" \
  --gpg-key "RPM-GPG-KEY-CentOS-8" \
  --url "http://centos.mirror.liquidtelecom.com/8/extras/x86_64/os/" \
  --mirror-on-sync "no"


hammer repository list 
--organization-id 3 
--product "CentOS Linux for x86_64"

hammer repository list

hammer repository list --organization-id 3 --product "CentOS 8 Linux for x86_64"




for i in $(seq 2 6); do \
  hammer repository synchronize --async --organization-id 3 \
  --product "CentOS 8 Linux for x86_64" \
  --id "$i"; \
  done

