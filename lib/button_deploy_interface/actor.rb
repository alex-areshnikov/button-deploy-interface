module ButtonDeployInterface
  class Actor
    def button_pressed(button)
      puts "#{button} pressed"
    end

    def button_released(button)
      puts "#{button} released"
    end
  end
end
