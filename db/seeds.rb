   User.create(name: 'Admin', email: "punch@example.com" , password: "punch1234") unless User.find_by_email("punch@example.com")
