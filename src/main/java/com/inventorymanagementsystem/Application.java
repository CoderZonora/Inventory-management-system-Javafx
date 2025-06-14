package com.inventorymanagementsystem;
import com.inventorymanagementsystem.config.Database;  // Add this import
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.stage.Stage;
import javafx.stage.StageStyle;
import java.io.IOException;
import static org.burningwave.core.assembler.StaticComponentContainer.Modules;

public class Application extends javafx.application.Application {
    private double x;
    private double y;

    @Override
    public void start(Stage stage) throws IOException {
        Parent root = FXMLLoader.load(getClass().getResource("login-view.fxml"));
        Scene scene = new Scene(root);
        stage.setTitle("Manipal Inventory Management System");
        root.setOnMousePressed((event)->{
            x=event.getSceneX();
            y=event.getSceneY();
        });
        root.setOnMouseDragged((event)->{
            stage.setX(event.getScreenX()-x);
            stage.setY(event.getScreenY()-y);
        });
        stage.initStyle(StageStyle.TRANSPARENT);
        stage.setScene(scene);
        stage.show();
    }

    @Override
    public void stop() {
        // Add this method to clean up database connection on application shutdown
        Database.getInstance().closeConnection();
    }

    public static void main(String[] args) {
        launch();
    }
}