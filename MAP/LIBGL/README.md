# LIBGL

https://github.com/ERRA3774/UNITBV/assets/93817419/cb43bea7-d812-450d-aa00-87c886424d63

```txt
Tema 2 - MVP ID

Se cere sa se dezvolte o aplicaţie implementată în limbajul C#, obligatoriu de tip WPF, platforma .NET Framework 4.5+,
Visual Studio 2019+, folosind server de baze de date Microsoft SQL Server 2019 sau mai nou.  

Aplicaţia trebuie să permită gestiunea unei biblioteci.
Se vor putea introduce şi modifica date legate de cărţi, tipuri de cărţi, edituri, autori, utilizatori si carti împrumutate.
Se doreşte validarea datelor introduse, tratarea excepţiilor, precum şi prezenţa structurii MVVM. 

Aplicaţia trebuie să permită adăugare, modificare şi ştergere în tabelele menţionate mai jos: 
• Edituri: tabela Publisher (PublisherId, Name,  Active) (0.5 p) 
• Autori:  tabela Author (AuthorId, FirstName, LastName, BirthDate, Active)  (0.5 p) 
• Tip de cărti: tabela BookType (BookTypeId, Name, Active) – ex: Manuale şcolare  (0.5 p) 
• Cărti: tabela Book (BookId, BookTypeId, PublisherId, Title, PublishYear, Stock, Active (0.5 p) 
• Se va crea o tabelă de legătură AuthorBook, deoarece o carte poate avea mai multi autori 
(Id, AuthorId, BookId, NumberInList– pentru a ajuta la afişarea autorilor în ordine) (0.5 p) 
• Utilizatori ai bibliotecii: User (UserId, FirstName,  LastName, Email, Phone, Active) (0.5 p) 
• O tabelă pentru împrumuturi: UserBook (Id, UserId, BookId, StartDate, ReturnDate) (0.5 p) 

Meniul va arăta astfel: EDITURI - AUTORI – TIPURI DE CĂRŢI - CĂRŢI – ÎMPRUMUTURI 

Pentru fiecare meniu vom avea două submeniuri: Lista (edituri, autori…) si Adaugă (editură/autor…). 
De exemplu, la click pe un anumit autor din lista de autori se va deschide o fereastră cu datele precompletate ale autorului
(id-ul său din baza de date nu se va afişa, ci va fi doar folosit pentru aducerea din baza de date a informaţiilor legate de
autorul selectat), iar la adăugarea unui nou autor se va deschide aceeaşi fereastră ca la editare, dar fără datele precompletate,
urmând a se insera un nou autor în baza de date cu un Id alocat automat în SQL Server (deci se va crea o singură fereastră pentru
adăugarea/editarea aceleiaşi entităţi).

Ştergerile din sistem se vor opera doar la nivel logic, setând Active = 0. 
De exemplu, un autor pentru care momentan nu mai avem nicio carte disponibilă se poate dezactiva pentru a nu se mai afişa în lista
de autori disponibili, dar nu se şterge din tabela ‘Author’, ci doar se marchează ca inactiv (Active = 0), pentru ca datele deja
adăugate despre autor să rămână în baza de date, putând fi reactivate în cazul aducerii în bibliotecă a unui exemplar al unei
cărţi scrise de acelaşi autor. 

Se va stoca în câmpul Stock numărul de exemplare pentru fiecare carte din bibliotecă. 
Disponibilitatea unei cărti va putea fi calculată și afișată în funcție de numărul de exemplare 1 (Stock în tabela Book) și de
numărul total de împrumuturi ale acelei cărți fără dată de returnare (cu ReturnDate NULL în tabela UserBook pentru cartea cu
respectivul BookId). 

Alte cerinţe: 
(3p): Se cere ca în fiecare listă accesată din meniu să fie posibilă căutarea (filtrarea) după 
unul sau două câmpuri, ca de exemplu: 
-căutarea în lista de autori a unui autor după Nume (LastName) 
-căutarea în lista de cărţi a unei cărţi după titlu (Title) 
- căutarea în lista de cărţi a cărţilor publicate de un anumit autor 

(1.5p): De asemenea, se cere ca în fiecare dintre liste să fie posibilă sortarea (ordonarea) 
după toate câmpurile/coloanele din grid, pentru a putea vedea, de exemplu: 
- cărţile publicate de un anumit autor selectat, ordonate după anul publicării cărţii  
- cărţile unei edituri selectate, ordonate după numele editurii  
- cărţile împrumutate de un anumit utilizator, ordonate după data împrumutului 

```

```txt
Project Root
    \_ Assets
        \__ Icons.xaml
    \_ Commands
        \__ CommandBase.cs
    \_ Databases
        \__ DbUtils.cs 
    \_ Models
        \__ Author.cs
        \__ AuthorBook.cs    
        \__ Book.cs    
        \__ BookType.cs    
        \__ Publisher.cs    
        \__ User.cs    
        \__ UserBook.cs    
    \_ Pages
        \__ AuthorDetailPage.xaml    
            \__ AuthorDetailPage.xaml.cs    
        \__ AuthorsPage.xaml    
            \__ AuthorsPage.xaml.cs    
        \__ BookDetailPage.xaml  
            \__ BookDetailPage.xaml.cs    
        \__ BooksPage.xaml    
            \__ BooksPage.xaml.cs    
        \__ BookGenreDetailPage.xaml    
            \__ BookGenreDetailPage.xaml.cs    
        \__ BookGenresPage.xaml    
            \__ BookGenresPage.xaml.cs   
         \__ BorrowedBookDetailPage.xaml    
            \__ BorrowedBookDetailPage.xaml.cs    
        \__ BorrowedBooksPage.xaml    
            \__ BorrowedBooksPage.xaml.cs  
         \__ PublisherDetailPage.xaml    
            \__ PublisherDetailPage.xaml.cs    
        \__ PublishersPage.xaml    
            \__ PublishersPage.xaml.cs 
         \__ UserDetailPage.xaml    
            \__ UserDetailPage.xaml.cs    
        \__ UsersPage.xaml    
            \__ UsersPage.xaml.cs
        \__ DashboardPage.xaml    
            \__ DashboardPage.xaml.cs 
        \__ HomePage.xaml    
            \__ HomePage.xaml.cs 
    \_ Resources
        \__ author.png
        \__ authorportrait.png
        \__ book.png
        \__ bookportrait.png
        \__ fallback.png
        \__ fallbackportrait.png
        \__ genre.png
        \__ genreportrait.png
        \__ logo.ico
        \__ logo.png
        \__ publisher.png
        \__ publisherportrait.png
        \__ user.png
        \__ userportrait.png
    \_ Styles
        \__ MainStyle.xaml
    \_ Themes
        \__ DarkTheme.xaml   
    \_ Utils
        \__ Consts.cs
    \_ ViewModels
        \__ AuthorDetailsViewModel.cs
        \__ AuthorsPageViewModel.cs
        \__ BookDetailsViewModel.cs
        \__ BooksPageViewModel.cs
        \__ BookGenreDetailsViewModel.cs
        \__ BookGenresPageViewModel.cs
        \__ BorrowedBookDetailsViewModel.cs
        \__ BorrowedBooksPageViewModel.cs
        \__ PublisherDetailsViewModel.cs
        \__ PublishersPageViewModel.cs
        \__ UserDetailsViewModel.cs
        \__ UsersPageViewModel.cs
        \__ HomePageViewModel.cs
        \__ DashboardPageViewModel.cs
        \__ ViewModelBase.cs
    \_ Views
        \__ UserSetupView.xaml
        \__ UserSetupView.xaml.cs
        \__ GameView.xaml
        \__ GameView.xaml.cs
    \_ App.config
    \_ App.xaml
    \_ App.xaml.cs
    \_ AssemblyInfo.cs
    \_ MainWindow.xaml
    \_ MainWindow.xaml.cs
```
MainWindow.xaml

```xml
<Window x:Class="LIBGL.MainWindow"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
        xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
        xmlns:views="clr-namespace:LIBGL.View"
        xmlns:local="clr-namespace:LIBGL"
        Name="WindowHome"
        WindowStyle="None"
        WindowStartupLocation="CenterScreen"
        Background="Transparent"
        AllowsTransparency="True"
        FontFamily="Poppins"
        ResizeMode="NoResize"
        mc:Ignorable="d"
        Title="MainWindow" Height="900" Width="1600">

    <Border Background="{DynamicResource BackgroundPrimaryColor}"
            CornerRadius="8">
        <Grid>
            <Grid.ColumnDefinitions>
                <ColumnDefinition Width="Auto"/>
                <ColumnDefinition Width="*"/>
            </Grid.ColumnDefinitions>

            <Border Grid.Column="0"
                    Background="{DynamicResource BackgroundSecondaryColor}"
                    CornerRadius="8 0 0 8">
                <Grid x:Name="GridNav" Width="60">
                    <Grid.RowDefinitions>
                        <RowDefinition Height="60"/>
                        <RowDefinition Height="*"/>
                    </Grid.RowDefinitions>

                    <Grid Grid.Row="0">
                        <Border 
                              Margin="12 0 0 0"
                              Width="36" Height="36"
                              HorizontalAlignment="Left">
                            <Border.Background>
                                <ImageBrush ImageSource="Resources/logo.png" Stretch="Uniform"/>
                            </Border.Background>
                        </Border>

                        <Label Content="📖 | LIBGL"
                               Foreground="{DynamicResource TextPrimaryColor}"
                               FontWeight="Bold"
                               FontSize="16"
                               VerticalAlignment="Center"
                               HorizontalAlignment="Left"
                               Margin="60 0 0 0"/>
                    </Grid>

                    <!-- Start: MenuItem -->
                    <StackPanel Grid.Row="1" Margin="-1 40 0 20">

                        <Button x:Name="ButtonHome" 
                                Style="{DynamicResource PopupButtonStyle}" 
                                MouseEnter="ButtonHome_MouseEnter" 
                                MouseLeave="ButtonHome_MouseLeave" 
                                Click="ButtonHome_Click">
                            
                            <views:MenuItem 
                                GroupName="MenuItem" 
                                IndicatorBrush="{DynamicResource PrimaryBlueColor}" 
                                Icon="{DynamicResource Home}" 
                                IconWidth="16" 
                                Text="Home" 
                                VerticalAlignment="Center"/>
                        </Button>

                        <Button x:Name="ButtonDashboard" 
                                Style="{DynamicResource PopupButtonStyle}"  
                                MouseEnter="ButtonDashboard_MouseEnter" 
                                MouseLeave="ButtonDashboard_MouseLeave" 
                                Click="ButtonDashboard_Click">
                            
                            <views:MenuItem 
                                GroupName="MenuItem" 
                                IndicatorBrush="{DynamicResource PrimaryBlueColor}" 
                                Icon="{DynamicResource Dashboard}" 
                                IconWidth="16" 
                                Text="Dashboard" 
                                VerticalAlignment="Center"/>
                        </Button>

                        <Button x:Name="ButtonUser" 
                                Style="{DynamicResource PopupButtonStyle}" 
                                MouseEnter="ButtonUser_MouseEnter" 
                                MouseLeave="ButtonUser_MouseLeave" 
                                Click="ButtonUser_Click">
                            <views:MenuItem 
                                GroupName="MenuItem" 
                                IndicatorBrush="{DynamicResource PrimaryBlueColor}" 
                                Icon="{DynamicResource User}" 
                                IconWidth="16" 
                                Text="Users" 
                                VerticalAlignment="Center"/>
                        </Button>

                        <Button x:Name="ButtonPublishers" 
                                Style="{DynamicResource PopupButtonStyle}"  
                                MouseEnter="ButtonPublishers_MouseEnter" 
                                MouseLeave="ButtonPublishers_MouseLeave" 
                                Click="ButtonPublishers_Click">
                            <views:MenuItem 
                                GroupName="MenuItem" 
                                IndicatorBrush="{DynamicResource PrimaryBlueColor}" 
                                Icon="{DynamicResource Publishers}" 
                                IconWidth="16" 
                                Text="Publishers" 
                                VerticalAlignment="Center"/>
                        </Button>

                        <Button x:Name="ButtonAuthors" 
                                Style="{DynamicResource PopupButtonStyle}"  
                                MouseEnter="ButtonAuthors_MouseEnter" 
                                MouseLeave="ButtonAuthors_MouseLeave" 
                                Click="ButtonAuthors_Click">
                            <views:MenuItem 
                                GroupName="MenuItem" 
                                IndicatorBrush="{DynamicResource PrimaryBlueColor}" 
                                Icon="{DynamicResource Authors}" 
                                IconWidth="16" 
                                Text="Authors" 
                                VerticalAlignment="Center"/>
                        </Button>

                        <Button x:Name="ButtonGenres" 
                                Style="{DynamicResource PopupButtonStyle}" 
                                MouseEnter="ButtonGenres_MouseEnter" 
                                MouseLeave="ButtonGenres_MouseLeave" 
                                Click="ButtonGenres_Click">
                            <views:MenuItem 
                                GroupName="MenuItem" 
                                IndicatorBrush="{DynamicResource PrimaryBlueColor}" 
                                Icon="{DynamicResource Genres}" 
                                IconWidth="16" 
                                Text="Genres" 
                                VerticalAlignment="Center"/>
                        </Button>

                        <Button x:Name="ButtonBooks" 
                                Style="{DynamicResource PopupButtonStyle}" 
                                MouseEnter="ButtonBooks_MouseEnter" 
                                MouseLeave="ButtonBooks_MouseLeave" 
                                Click="ButtonBooks_Click">
                            <views:MenuItem 
                                GroupName="MenuItem" 
                                IndicatorBrush="{DynamicResource PrimaryBlueColor}" 
                                Icon="{DynamicResource Books}" 
                                IconWidth="16" 
                                Text="Books" 
                                VerticalAlignment="Center"/>
                        </Button>

                        <Button x:Name="ButtonBorrowedBooks" 
                                Style="{DynamicResource PopupButtonStyle}" 
                                MouseEnter="ButtonBorrowedBooks_MouseEnter" 
                                MouseLeave="ButtonBorrowedBooks_MouseLeave" 
                                Click="ButtonBorrowedBooks_Click">
                            <views:MenuItem 
                                GroupName="MenuItem" 
                                IndicatorBrush="{DynamicResource PrimaryBlueColor}" 
                                Icon="{DynamicResource BorrowedBooks}" 
                                IconWidth="16" 
                                Text="Borrowed Books" 
                                VerticalAlignment="Center"/>
                        </Button>

                        <Button x:Name="ButtonSecurity" 
                                Style="{DynamicResource PopupButtonStyle}" 
                                MouseEnter="ButtonSecurity_MouseEnter" 
                                MouseLeave="ButtonSecurity_MouseLeave">
                            <views:MenuItem 
                                GroupName="MenuItem" 
                                IndicatorBrush="{DynamicResource PrimaryBlueColor}" 
                                Icon="{DynamicResource Lock}" 
                                IconWidth="16" 
                                Text="Security" 
                                VerticalAlignment="Center"/>
                        </Button>

                        <Button x:Name="ButtonSettings" 
                                Style="{DynamicResource PopupButtonStyle}" 
                                MouseEnter="ButtonSettings_MouseEnter" 
                                MouseLeave="ButtonSettings_MouseLeave">
                            <views:MenuItem 
                                GroupName="MenuItem" 
                                IndicatorBrush="{DynamicResource PrimaryBlueColor}" 
                                Icon="{DynamicResource Settings}" 
                                IconWidth="16" 
                                Text="Setting" 
                                VerticalAlignment="Center"/>
                        </Button>

                    </StackPanel>
                    <!-- End: MenuItem -->

                    <!-- Start: Popup User Control -->
                    <Popup x:Name="Popup" 
                           AllowsTransparency="True" 
                           HorizontalOffset="0" 
                           VerticalOffset="10">
                        <views:UserPopup x:Name="Header" Foreground="{DynamicResource TextPrimaryColor}"/>
                    </Popup>
                    <!-- End: Popup User Control -->

                </Grid>
            </Border>

            <Grid Grid.Column="1">
                <Grid.RowDefinitions>
                    <RowDefinition Height="60"/>
                    <RowDefinition Height="*"/>
                </Grid.RowDefinitions>

                <ToggleButton x:Name="Tg_Btn" 
                              Grid.Column="1" 
                              VerticalAlignment="Center" 
                              Style="{DynamicResource IToggleButtonStyle}" 
                              HorizontalAlignment="Left" 
                              BorderThickness="0" 
                              Background="Transparent" 
                              Margin="10,15,0,15" 
                              Height="30" 
                              Width="30">
                    <ToggleButton.Triggers>
                        <EventTrigger RoutedEvent="ToggleButton.Unchecked">
                            <BeginStoryboard>
                                <Storyboard x:Name="HideStackPanel">
                                    <DoubleAnimation 
                                        Storyboard.TargetName="GridNav" 
                                        Storyboard.TargetProperty="Width" 
                                        BeginTime="0:0:0" 
                                        From="210" 
                                        To="60" 
                                        Duration="0:0:0.5">
                                    </DoubleAnimation>
                                </Storyboard>
                            </BeginStoryboard>
                        </EventTrigger>
                        <EventTrigger RoutedEvent="ToggleButton.Checked">
                            <BeginStoryboard>
                                <Storyboard x:Name="ShowStackPanel">
                                    <DoubleAnimation 
                                        Storyboard.TargetName="GridNav" 
                                        Storyboard.TargetProperty="Width" 
                                        BeginTime="0:0:0" 
                                        From="60" 
                                        To="210" 
                                        Duration="0:0:0.5">
                                    </DoubleAnimation>
                                </Storyboard>
                            </BeginStoryboard>
                        </EventTrigger>
                    </ToggleButton.Triggers>
                </ToggleButton>

                <!-- Start: Button Close | Restore | Minimize -->
                <StackPanel 
                    Grid.Row="0" 
                    HorizontalAlignment="Right" 
                    VerticalAlignment="Top" 
                    Margin="0,5,10,0" 
                    Height="30" 
                    Orientation="Horizontal" 
                    FlowDirection="RightToLeft" 
                    Grid.RowSpan="2">
                    <Button x:Name="ButtonClose" 
                            Style="{StaticResource IconButtonsStyle}" 
                            Content="{DynamicResource Close}" 
                            Click="ButtonClose_Click" 
                            Tag="IsCloseButton"/>
                    <Button x:Name="ButtonRestore" 
                            Margin="5,0" 
                            Click="ButtonRestore_Click">
                        <Button.Style>
                            <Style 
                                TargetType="{x:Type Button}" 
                                BasedOn="{StaticResource IconButtonsStyle}">
                                <Setter 
                                    Property="Content" 
                                    Value="{DynamicResource Maximize}"/>
                                <Style.Triggers>
                                    <DataTrigger 
                                        Binding="{Binding ElementName=WindowHome, Path=WindowState}" 
                                        Value="Maximized">
                                        <Setter Property="Content" Value="{DynamicResource Restore}"/>
                                    </DataTrigger>
                                </Style.Triggers>
                            </Style>
                        </Button.Style>
                    </Button>
                    <Button x:Name="ButtonMinimize" 
                            Style="{DynamicResource IconButtonsStyle}" 
                            Content="{DynamicResource Minimize}" Click="ButtonMinimize_Click"/>
                </StackPanel>
                <!-- End: Button Close | Restore | Minimize -->

                <Frame Grid.Row="1"
                       Name="fContainer"
                       Margin="20"
                       NavigationUIVisibility="Hidden">

                </Frame>

            </Grid>

        </Grid>
    </Border>

</Window>
```

MainWindow.xaml.cs

```cs
using System.Windows;
using System.Windows.Controls.Primitives;
using System.Windows.Input;

using LIBGL.Utils;
using LIBGL.Pages;

namespace LIBGL
{
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
        }

        private void BG_PreviewMouseLeftButtonDown(object sender, MouseButtonEventArgs e)
        {
            Tg_Btn.IsChecked = false;
        }



        private void ButtonHome_MouseEnter(object sender, MouseEventArgs e)
        {
            if (Tg_Btn.IsChecked == true)
            {
                return;
            }

            Popup.PlacementTarget = ButtonHome;
            Popup.Placement = PlacementMode.Right;
            Popup.IsOpen = true;
            Header.PopupText.Text = Consts.HOME_PAGE_TITLE;
        }

        private void ButtonHome_MouseLeave(object sender, MouseEventArgs e)
        {
            Popup.Visibility = Visibility.Collapsed;
            Popup.IsOpen = false;
        }



        private void ButtonUser_MouseEnter(object sender, MouseEventArgs e)
        {
            if (Tg_Btn.IsChecked == true)
            {
                return;
            }

            Popup.PlacementTarget = ButtonUser;
            Popup.Placement = PlacementMode.Right;
            Popup.IsOpen = true;
            Header.PopupText.Text = Consts.USERS_PAGE_TITLE;
        }

        private void ButtonUser_MouseLeave(object sender, MouseEventArgs e)
        {
            Popup.Visibility = Visibility.Collapsed;
            Popup.IsOpen = false;
        }



        private void ButtonDashboard_MouseEnter(object sender, MouseEventArgs e)
        {
            if (Tg_Btn.IsChecked == true)
            {
                return;
            }

            Popup.PlacementTarget = ButtonDashboard;
            Popup.Placement = PlacementMode.Right;
            Popup.IsOpen = true;
            Header.PopupText.Text = Consts.DASHBOARD_PAGE_TITLE;
        }

        private void ButtonDashboard_MouseLeave(object sender, MouseEventArgs e)
        {
            Popup.Visibility = Visibility.Collapsed;
            Popup.IsOpen = false;
        }



        private void ButtonPublishers_MouseEnter(object sender, MouseEventArgs e)
        {
            if (Tg_Btn.IsChecked == true)
            {
                return;
            }

            Popup.PlacementTarget = ButtonPublishers;
            Popup.Placement = PlacementMode.Right;
            Popup.IsOpen = true;
            Header.PopupText.Text = Consts.PUBLISHERS_PAGE_TITLE;

        }

        private void ButtonPublishers_MouseLeave(object sender, MouseEventArgs e)
        {
            Popup.Visibility = Visibility.Collapsed;
            Popup.IsOpen = false;
        }



        private void ButtonAuthors_MouseEnter(object sender, MouseEventArgs e)
        {
            if (Tg_Btn.IsChecked == true)
            {
                return;
            }

            Popup.PlacementTarget = ButtonAuthors;
            Popup.Placement = PlacementMode.Right;
            Popup.IsOpen = true;
            Header.PopupText.Text = Consts.AUTHORS_PAGE_TITLE;
        }

        private void ButtonAuthors_MouseLeave(object sender, MouseEventArgs e)
        {
            Popup.Visibility = Visibility.Collapsed;
            Popup.IsOpen = false;
        }



        private void ButtonGenres_MouseEnter(object sender, MouseEventArgs e)
        {
            if (Tg_Btn.IsChecked == true)
            {
                return;
            }

            Popup.PlacementTarget = ButtonGenres;
            Popup.Placement = PlacementMode.Right;
            Popup.IsOpen = true;
            Header.PopupText.Text = Consts.GENRES_PAGE_TITLE;
        }

        private void ButtonGenres_MouseLeave(object sender, MouseEventArgs e)
        {
            Popup.Visibility = Visibility.Collapsed;
            Popup.IsOpen = false;
        }



        private void ButtonBooks_MouseEnter(object sender, MouseEventArgs e)
        {
            if (Tg_Btn.IsChecked == true)
            {
                return;
            }

            Popup.PlacementTarget = ButtonBooks;
            Popup.Placement = PlacementMode.Right;
            Popup.IsOpen = true;
            Header.PopupText.Text = Consts.BOOKS_PAGE_TITLE;
        }

        private void ButtonBooks_MouseLeave(object sender, MouseEventArgs e)
        {
            Popup.Visibility = Visibility.Collapsed;
            Popup.IsOpen = false;
        }



        private void ButtonBorrowedBooks_MouseEnter(object sender, MouseEventArgs e)
        {
            if (Tg_Btn.IsChecked == true)
            {
                return;
            }

            Popup.PlacementTarget = ButtonBorrowedBooks;
            Popup.Placement = PlacementMode.Right;
            Popup.IsOpen = true;
            Header.PopupText.Text = Consts.BORROWED_BOOKS_PAGE_TITLE;
        }

        private void ButtonBorrowedBooks_MouseLeave(object sender, MouseEventArgs e)
        {
            Popup.Visibility = Visibility.Collapsed;
            Popup.IsOpen = false;
        }



        private void ButtonSecurity_MouseEnter(object sender, MouseEventArgs e)
        {
            if (Tg_Btn.IsChecked == true)
            {
                return;
            }

            Popup.PlacementTarget = ButtonSecurity;
            Popup.Placement = PlacementMode.Right;
            Popup.IsOpen = true;
            Header.PopupText.Text = Consts.COMING_SOON_TEXT;
        }

        private void ButtonSecurity_MouseLeave(object sender, MouseEventArgs e)
        {
            Popup.Visibility = Visibility.Collapsed;
            Popup.IsOpen = false;
        }



        private void ButtonSettings_MouseEnter(object sender, MouseEventArgs e)
        {
            if (Tg_Btn.IsChecked == true)
            {
                return;
            }

            Popup.PlacementTarget = ButtonSettings;
            Popup.Placement = PlacementMode.Right;
            Popup.IsOpen = true;
            Header.PopupText.Text = Consts.COMING_SOON_TEXT;
        }

        private void ButtonSettings_MouseLeave(object sender, MouseEventArgs e)
        {
            Popup.Visibility = Visibility.Collapsed;
            Popup.IsOpen = false;
        }



        private void ButtonClose_Click(object sender, RoutedEventArgs e)
        {
            Close();
        }

        private void ButtonRestore_Click(object sender, RoutedEventArgs e)
        {
            WindowState = WindowState == WindowState.Normal ? WindowState.Maximized : WindowState.Normal;
        }

        private void ButtonMinimize_Click(object sender, RoutedEventArgs e)
        {
            WindowState = WindowState.Minimized;
        }


        private void ButtonHome_Click(object sender, RoutedEventArgs e)
        {
            fContainer.Navigate(new HomePage());
        }

        private void ButtonUser_Click(object sender, RoutedEventArgs e)
        {
            fContainer.Navigate(new UsersPage());
        }

        private void ButtonDashboard_Click(object sender, RoutedEventArgs e)
        {
            fContainer.Navigate(new DashboardPage());
        }

        private void ButtonPublishers_Click(object sender, RoutedEventArgs e)
        {
            fContainer.Navigate(new PublishersPage());
        }

        private void ButtonAuthors_Click(object sender, RoutedEventArgs e)
        {
            fContainer.Navigate(new AuthorsPage());
        }

        private void ButtonGenres_Click(object sender, RoutedEventArgs e)
        {
            fContainer.Navigate(new BookGenresPage());
        }

        private void ButtonBooks_Click(object sender, RoutedEventArgs e)
        {
            fContainer.Navigate(new BooksPage());
        }

        private void ButtonBorrowedBooks_Click(object sender, RoutedEventArgs e)
        {
            fContainer.Navigate(new BorrowedBooksPage());
        }

    }
}
```

MenuItem.xaml

```xml
<UserControl x:Class="LIBGL.View.MenuItem"
             xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
             xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
             xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006" 
             xmlns:d="http://schemas.microsoft.com/expression/blend/2008" 
             xmlns:local="clr-namespace:LIBGL.View"
             Name="this"
             mc:Ignorable="d"
             d:DesignHeight="450" d:DesignWidth="800">

    <UserControl.Resources>

        <!-- Start: Indicator Style -->
        <Style x:Key="IndicatorStyle" TargetType="{x:Type Border}">
            <Setter Property="CornerRadius" Value="0 5 5 0"/>
            <Setter Property="Background" Value="{DynamicResource PrimaryBlueColor}"/>
            <Setter Property="Visibility" Value="Hidden"/>
            <Setter Property="Height" Value="35"/>
            <Setter Property="Width" Value="4"/>
            <Setter Property="HorizontalAlignment" Value="Left"/>
            <Setter Property="VerticalAlignment" Value="Center"/>
            <Style.Triggers>
                <DataTrigger Binding="{Binding IsMouseOver, RelativeSource={RelativeSource Mode=FindAncestor, AncestorType=ToggleButton}}" Value="True">
                    <Setter Property="Visibility" Value="Visible"/>
                    <Setter Property="Background" Value="{DynamicResource TextQuarternaryColor}"/>
                </DataTrigger>
                <DataTrigger Binding="{Binding IsChecked, RelativeSource={RelativeSource Mode=FindAncestor, AncestorType=ToggleButton}}" Value="True">
                    <Setter Property="Visibility" Value="Visible"/>
                    <Setter Property="Background" Value="{DynamicResource PrimaryBlueColor}"/>
                </DataTrigger>
            </Style.Triggers>
        </Style>
        <!-- End: Indicator Style -->

        <!-- Start: Menu Icon Style -->
        <Style x:Key="MenuIconStyle" TargetType="{x:Type Path}">
            <Setter Property="Fill" Value="{DynamicResource IconSecondaryColor}"/>
            <Style.Triggers>
                <DataTrigger Binding="{Binding IsMouseOver, RelativeSource={RelativeSource Mode=FindAncestor, AncestorType=ToggleButton}}" Value="True">
                    <Setter Property="Fill" Value="{DynamicResource TextQuarternaryColor}"/>
                </DataTrigger>
                <DataTrigger Binding="{Binding IsChecked, RelativeSource={RelativeSource Mode=FindAncestor, AncestorType=ToggleButton}}" Value="True">
                    <Setter Property="Fill" Value="{DynamicResource PrimaryBlueColor}"/>
                </DataTrigger>
            </Style.Triggers>
        </Style>
        <!-- End: Menu Icon Style -->

        <!-- Start: Menu Text Style -->
        <Style x:Key="MenuTextStyle" TargetType="{x:Type TextBlock}">
            <Setter Property="Foreground" Value="{DynamicResource IconSecondaryColor}"/>
            <Setter Property="VerticalAlignment" Value="Center"/>
            <Setter Property="FontSize" Value="12"/>
            <Setter Property="FontWeight" Value="Regular"/>
            <Setter Property="Margin" Value="18 0 0 0"/>
            <Style.Triggers>
                <DataTrigger Binding="{Binding IsMouseOver, RelativeSource={RelativeSource Mode=FindAncestor, AncestorType=ToggleButton}}" Value="True">
                    <Setter Property="Foreground" Value="{DynamicResource TextQuarternaryColor}"/>
                </DataTrigger>
                <DataTrigger Binding="{Binding IsChecked, RelativeSource={RelativeSource Mode=FindAncestor, AncestorType=ToggleButton}}" Value="True">
                    <Setter Property="Foreground" Value="{DynamicResource PrimaryBlueColor}"/>
                </DataTrigger>
            </Style.Triggers>
        </Style>
        <!-- End: Menu Text Style -->

        <!-- Start: Menu Item Style -->
        <Style x:Key="MenuButtonStyle" TargetType="{x:Type ToggleButton}">
            <Setter Property="Background" Value="Transparent"/>
            <Setter Property="BorderThickness" Value="{DynamicResource BorderThickness}"/>
            <Setter Property="HorizontalContentAlignment" Value="Center"/>
            <Setter Property="Width" Value="250"/>
            <Setter Property="Height" Value="40"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="{x:Type ToggleButton}">
                        <Border Background="{TemplateBinding Background}" BorderThickness="{TemplateBinding BorderThickness}" Padding="{Binding Padding, ElementName=this}">
                            <Grid>
                                <Grid.ColumnDefinitions>
                                    <ColumnDefinition Width="60"/>
                                    <ColumnDefinition/>
                                </Grid.ColumnDefinitions>

                                <!-- Indicator -->
                                <Border Style="{StaticResource IndicatorStyle}"/>

                                <!-- Icon -->
                                <Path Data="{Binding Icon, ElementName=this, FallbackValue={StaticResource DefaultIcon}, TargetNullValue={StaticResource DefaultIcon}}" Margin="{Binding IconMargin, FallbackValue='0,0,0,0', TargetNullValue='20,0,0,0'}"
                                      Stretch="Uniform" Width="{Binding IconWidth, ElementName=this, FallbackValue=20,TargetNullValue=20}" Style="{StaticResource MenuIconStyle}"/>

                                <!-- Menu Text -->
                                <TextBlock Style="{StaticResource MenuTextStyle}" FontWeight="Regular" FontSize="14" Grid.Column="1" Text="{Binding Text, ElementName=this, FallbackValue=MenuText, TargetNullValue=MenuText}" Margin="0,0,0,0"/>

                            </Grid>
                        </Border>
                        <ControlTemplate.Triggers>
                            <!-- To set IsChecked property to true on default -->
                            <DataTrigger Binding="{Binding IsSelected, ElementName=this}" Value="True">
                                <Setter Property="IsChecked" Value="True"/>
                            </DataTrigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>
        <!-- End: Menu Item Style -->

    </UserControl.Resources>

    <Grid>
        <RadioButton Style="{StaticResource MenuButtonStyle}" GroupName="{Binding GroupName, ElementName=this}"/>
    </Grid>

</UserControl>

```

MenuItem.xaml.cs
```cs
using System.Windows;
using System.Windows.Controls;
using System.Windows.Media;

namespace LIBGL.View
{
    public partial class MenuItem : UserControl
    {
        public MenuItem()
        {
            InitializeComponent();
        }

        public PathGeometry Icon
        {
            get { return (PathGeometry)GetValue(IconProperty); }
            set { SetValue(IconProperty, value); }
        }

        // Using a DependencyProperty as the backing store for Icon. This enables animation, styling, binding, etc...
        public static readonly DependencyProperty IconProperty = DependencyProperty.Register("Icon", typeof(PathGeometry), typeof(MenuItem));



        public int IconWidth
        {
            get { return (int)GetValue(IconWidthProperty); }
            set { SetValue(IconWidthProperty, value); }
        }

        // Using a DependencyProperty as the backing store for IconWidth. This enables animation, styling, binding, etc...
        public static readonly DependencyProperty IconWidthProperty = DependencyProperty.Register("IconWidth", typeof(int), typeof(MenuItem));



        public SolidColorBrush IndicatorBrush
        {
            get { return (SolidColorBrush)GetValue(IndicatorBrushProperty); }
            set { SetValue(IndicatorBrushProperty, value); }
        }

        // Using a DependencyProperty as the backing store for IndicatorBrush. This enables animation, styling, binding, etc...
        public static readonly DependencyProperty IndicatorBrushProperty = DependencyProperty.Register("IndicatorBrush", typeof(SolidColorBrush), typeof(MenuItem));



        public int IndicatorIndicatorCornerRadius
        {
            get { return (int)GetValue(IndicatorIndicatorCornerRadiusProperty); }
            set { SetValue(IndicatorIndicatorCornerRadiusProperty, value); }
        }

        // Using a DependencyProperty as the backing store for IndicatorIndicatorCornerRadius. This enables animation, styling, binding, etc...
        public static readonly DependencyProperty IndicatorIndicatorCornerRadiusProperty = DependencyProperty.Register("IndicatorIndicatorCornerRadius", typeof(int), typeof(MenuItem));



        public string Text
        {
            get { return (string)GetValue(TextProperty); }
            set { SetValue(TextProperty, value); }
        }

        // Using a DependencyProperty as the backing store for Text. This enables animation, styling, binding, etc...
        public static readonly DependencyProperty TextProperty = DependencyProperty.Register("Text", typeof(string), typeof(MenuItem));



        public new Thickness Padding
        {
            get { return (Thickness)GetValue(PaddingProperty); }
            set { SetValue(PaddingProperty, value); }
        }

        // Using a DependencyProperty as the backing store for Padding. This enables animation, styling, binding, etc...
        public static new readonly DependencyProperty PaddingProperty = DependencyProperty.Register("Padding", typeof(Thickness), typeof(MenuItem));



        public bool IsSelected
        {
            get { return (bool)GetValue(IsSelectedProperty); }
            set { SetValue(IsSelectedProperty, value); }
        }

        // Using a DependencyProperty as the backing store for IsSelected. This enables animation, styling, binding, etc...
        public static readonly DependencyProperty IsSelectedProperty = DependencyProperty.Register("IsSelected", typeof(bool), typeof(MenuItem));



        public string GroupName
        {
            get { return (string)GetValue(GroupNameProperty); }
            set { SetValue(GroupNameProperty, value); }
        }

        // Using a DependencyProperty as the backing store for GroupName. This enables animation, styling, binding, etc...
        public static readonly DependencyProperty GroupNameProperty = DependencyProperty.Register("GroupName", typeof(string), typeof(MenuItem));

    }
}

```

UserPopup.xaml
```xml
<UserControl x:Class="LIBGL.View.UserPopup"
             xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
             xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
             xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006" 
             xmlns:d="http://schemas.microsoft.com/expression/blend/2008" 
             xmlns:local="clr-namespace:LIBGL.View"
             mc:Ignorable="d" 
             d:DesignHeight="450" d:DesignWidth="800">

    <UserControl.Style>
        <Style>
            <Style.Triggers>
                <EventTrigger RoutedEvent="FrameworkElement.Loaded">
                    <BeginStoryboard>
                        <Storyboard>
                            <DoubleAnimation Storyboard.TargetProperty="Opacity" Duration="00:00:02" From="0" To="1"/>
                        </Storyboard>
                    </BeginStoryboard>
                </EventTrigger>
                <Trigger Property="FrameworkElement.Visibility" Value="Collapsed">
                    <Setter Property="FrameworkElement.Opacity" Value="0"/>
                </Trigger>
            </Style.Triggers>
        </Style>
    </UserControl.Style>

    <Grid>
        <!-- Start: Popup User Control -->
        <Border x:Name="Conatiner" CornerRadius="5" Width="Auto" Height="30" Margin="10 0 0 0" Background="{DynamicResource PrimaryBlueColor}" HorizontalAlignment="Center" VerticalAlignment="Center">
            <!-- Star: Reusable Text -->
            <TextBlock x:Name="PopupText" FontSize="14" FontWeight="Regular" Panel.ZIndex="1" HorizontalAlignment="Center" VerticalAlignment="Center" Margin="10 5 10 5"/>
            <!-- Star: Reusable Text -->
        </Border>
        <!-- End: Popup User Control -->
    </Grid>
    
</UserControl>

```

UserPopup.xaml.cs
```cs
using System.Windows.Controls;

namespace LIBGL.View
{
    public partial class UserPopup : UserControl
    {
        public UserPopup()
        {
            InitializeComponent();
        }
    }
}
```

CommandBase.cs

```cs
using System.Windows.Input;

namespace LIBGL.Commands
{
    public abstract class CommandBase : ICommand
    {
        public event EventHandler? CanExecuteChanged;

        public virtual bool CanExecute(object? parameter)
        {
            return true;
        }

        public abstract void Execute(object? parameter);

        protected void OnCanExecuteChanged()
        {
            CanExecuteChanged?.Invoke(this, EventArgs.Empty);
        }
    }
}
```

ViewModelBase.cs

```cs
using System.ComponentModel;

namespace LIBGL.ViewModels
{
    public class ViewModelBase : INotifyPropertyChanged
    {
        public event PropertyChangedEventHandler? PropertyChanged;

        protected void OnPropertyChanged(string propertyName)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }
    }
}
```

DbUtils.cs

```cs
using System.Data;
using System.Diagnostics;

using Microsoft.Data.SqlClient;

using LIBGL.Utils;
using LIBGL.Models;

namespace LIBGL.Databases
{
    public class DbUtils
    {
        public static readonly string CONNECTION_STRING = System.Configuration.ConfigurationManager.ConnectionStrings["SSMSConnection"].ConnectionString;

        public static int InsertBook(Models.Book book)
        {
            using (SqlConnection connection = new SqlConnection(CONNECTION_STRING))
            {
                SqlCommand sqlCmd = new SqlCommand(Consts.BOOK_INSERT, connection);
                sqlCmd.CommandType = CommandType.StoredProcedure;

                sqlCmd.Parameters.Add("@Title", SqlDbType.NVarChar);
                sqlCmd.Parameters["@Title"].Value = book.Title;

                sqlCmd.Parameters.Add("@BookTypeId", SqlDbType.Int);
                sqlCmd.Parameters["@BookTypeId"].Value = book.BookTypeId;

                sqlCmd.Parameters.Add("@PublisherId", SqlDbType.Int);
                sqlCmd.Parameters["@PublisherId"].Value = book.PublisherId;

                sqlCmd.Parameters.Add("@Stock", SqlDbType.Int);
                sqlCmd.Parameters["@Stock"].Value = book.Stock;

                sqlCmd.Parameters.Add("@PublishYear", SqlDbType.Int);
                sqlCmd.Parameters["@PublishYear"].Value = book.PublishYear;

                try
                {
                    connection.Open();
                    object result = sqlCmd.ExecuteScalar();
                    
                    if (result != null)
                    {
                        return Convert.ToInt32(result);
                    }
                    else
                    {
                        Debug.WriteLine("LIBGL    [W]     No BookId returned after inserting new book.");
                        return int.MinValue;
                    }

                }
                catch (Exception ex)
                {
                    Debug.WriteLine($"LIBGL    [W]     Exception caught while adding new book. {ex.Message}");
                    return int.MinValue;
                }
            }
        }

        public static bool UpdateBook(Models.Book book)
        {
            using (SqlConnection connection = new SqlConnection(CONNECTION_STRING))
            {
                SqlCommand sqlCmd = new SqlCommand(Consts.BOOK_UPDATE, connection);

                sqlCmd.CommandType = CommandType.StoredProcedure;
                sqlCmd.Parameters.Add("@BookId", SqlDbType.Int);
                sqlCmd.Parameters["@BookId"].Value = book.BookId;

                sqlCmd.Parameters.Add("@BookTypeId", SqlDbType.Int);
                sqlCmd.Parameters["@BookTypeId"].Value = book.BookTypeId;

                sqlCmd.Parameters.Add("@PublisherId", SqlDbType.Int);
                sqlCmd.Parameters["@PublisherId"].Value = book.PublisherId;

                sqlCmd.Parameters.Add("@Title", SqlDbType.NVarChar);
                sqlCmd.Parameters["@Title"].Value = book.Title;

                sqlCmd.Parameters.Add("@PublishYear", SqlDbType.Int);
                sqlCmd.Parameters["@PublishYear"].Value = book.PublishYear;

                sqlCmd.Parameters.Add("@Stock", SqlDbType.Int);
                sqlCmd.Parameters["@Stock"].Value = book.Stock;

                sqlCmd.Parameters.Add("@Active", SqlDbType.Bit);
                sqlCmd.Parameters["@Active"].Value = book.Active;

                try
                {
                    connection.Open();
                    sqlCmd.ExecuteNonQuery();
                    return true;
                }
                catch (Exception ex)
                {
                    Debug.WriteLine($"LIBGL    [W]     Exception caught while updating book with id: {book.BookId}. {ex.Message}");
                    return false;
                }
            }
        }

        public static Models.Book? GetBook(int bookId)
        {
            Models.Book? book = null;

            using (SqlConnection connection = new SqlConnection(CONNECTION_STRING))
            {
                SqlCommand sqlCmd = new SqlCommand(Consts.BOOK_SELECT, connection);

                sqlCmd.CommandType = CommandType.StoredProcedure;
                sqlCmd.Parameters.Add("@BookId", SqlDbType.Int);
                sqlCmd.Parameters["@BookId"].Value = bookId;

                try
                {
                    connection.Open();
                    SqlDataReader reader = sqlCmd.ExecuteReader();

                    if (reader.Read())
                    {
                        book = new Models.Book
                        {
                            BookId = (int)(reader["BookId"]),
                            BookTypeId = (int)reader["BookTypeId"],
                            PublisherId = (int)reader["PublisherId"],
                            Title = reader["Title"].ToString() ?? string.Empty,
                            PublishYear = (int)reader["PublishYear"],
                            Stock = (int)reader["Stock"],
                            Active = (bool)reader["Active"]
                        };
                    }
                }
                catch (Exception ex)
                {
                    Debug.WriteLine($"LIBGL    [W]     Exception caught while retrieving book with id: {bookId}. {ex.Message}");
                }
            }

            return book;
        }

        public static bool DeleteBook(int bookId)
        {
            using (SqlConnection connection = new SqlConnection(CONNECTION_STRING))
            {
                SqlCommand sqlCmd = new SqlCommand(Consts.BOOK_DELETE, connection);

                sqlCmd.CommandType = CommandType.StoredProcedure;
                sqlCmd.Parameters.Add("@BookId", SqlDbType.Int);
                sqlCmd.Parameters["@BookId"].Value = bookId;

                try
                {
                    connection.Open();
                    sqlCmd.ExecuteNonQuery();
                    return true;
                }
                catch (Exception ex)
                {
                    Debug.WriteLine($"LIBGL    [W]     Exception caught while deleting book with id: {bookId}. {ex.Message}");
                    return false;
                }
            }
        }

        public static List<Models.Book> GetAllActiveBooks()
        {
            List<Models.Book> books = new List<Models.Book>();

            using (SqlConnection connection = new SqlConnection(CONNECTION_STRING))
            {
                SqlCommand sqlCmd = new SqlCommand(Consts.BOOK_ALL_ACTIVE_SELECT, connection);
                sqlCmd.CommandType = CommandType.StoredProcedure;

                try
                {
                    connection.Open();
                    SqlDataReader reader = sqlCmd.ExecuteReader();

                    while (reader.Read())
                    {
                        Models.Book book = new Models.Book
                        {
                            BookId = (int)(reader["BookId"]),
                            BookTypeId = (int)reader["BookTypeId"],
                            PublisherId = (int)reader["PublisherId"],
                            Title = reader["Title"].ToString() ?? string.Empty,
                            PublishYear = (int)reader["PublishYear"],
                            Stock = (int)reader["Stock"],
                            Active = (bool)reader["Active"]
                        };
                        books.Add(book);
                    }
                }
                catch (Exception ex)
                {
                    Debug.WriteLine($"LIBGL    [W]     Exception caught while retrieving books. {ex.Message}");
                }
            }

            return books;
        }

        public static List<Models.Book> GetAllBooks()
        {
            List<Models.Book> books = new List<Models.Book>();

            using (SqlConnection connection = new SqlConnection(CONNECTION_STRING))
            {
                SqlCommand sqlCmd = new SqlCommand(Consts.BOOK_ALL_SELECT, connection);
                sqlCmd.CommandType = CommandType.StoredProcedure;

                try
                {
                    connection.Open();
                    SqlDataReader reader = sqlCmd.ExecuteReader();

                    while (reader.Read())
                    {
                        Models.Book book = new Models.Book
                        {
                            BookId = (int)(reader["BookId"]),
                            BookTypeId = (int)reader["BookTypeId"],
                            PublisherId = (int)reader["PublisherId"],
                            Title = reader["Title"].ToString() ?? string.Empty,
                            PublishYear = (int)reader["PublishYear"],
                            Stock = (int)reader["Stock"],
                            Active = (bool)reader["Active"]
                        };
                        books.Add(book);
                    }
                }
                catch (Exception ex)
                {
                    Debug.WriteLine($"LIBGL    [W]     Exception caught while retrieving books. {ex.Message}");
                }
            }

            return books;
        }

    }

}

```

Book.cs

```cs
namespace LIBGL.Models
{
    public class Book
    {
        public int BookId { get; set; }
        public int BookTypeId { get; set; }
        public int PublisherId { get; set; }
        public string Title { get; set; }
        public int PublishYear { get; set; }
        public int Stock { get; set; }
        public bool Active { get; set; }

        public Book()
        {
            BookId = int.MinValue;
            BookTypeId = int.MinValue;
            PublisherId = int.MinValue;
            Title = string.Empty;
            PublishYear = DateTime.Now.Year;
            Stock = 0;
            Active = false;
        }
    }
}
```

BooksPage.xaml

```xml
<Page x:Class="LIBGL.Pages.BooksPage"
      xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
      xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
      xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006" 
      xmlns:d="http://schemas.microsoft.com/expression/blend/2008" 
      xmlns:local="clr-namespace:LIBGL.Pages"
      xmlns:vms="clr-namespace:LIBGL.ViewModels"
      d:DataContext="{d:DesignInstance Type=vms:BooksPageViewModel}"
      mc:Ignorable="d" 
      d:DesignHeight="450" d:DesignWidth="800"
      Title="BooksPage">

    <Border CornerRadius="5" Background="{DynamicResource BackgroundSecondaryColor}">
        <Grid HorizontalAlignment="Center">

            <Grid.RowDefinitions>
                <RowDefinition Height="Auto"/>
                <RowDefinition Height="Auto"/>
                <RowDefinition Height="Auto"/>
            </Grid.RowDefinitions>

            <Grid Grid.Row="0">
                <TextBlock Margin="20"
                       Grid.Row="0" 
                       Text="{Binding Title}" 
                       FontSize="50" 
                       Foreground="{DynamicResource TextPrimaryColor}" 
                       FontWeight="Bold" 
                       VerticalAlignment="Center" 
                       HorizontalAlignment="Center">
                </TextBlock>
            </Grid>


            <Grid Grid.Row="1">
                <DataGrid x:Name="DataGridBooks"
                   MouseDoubleClick="DataGridBooks_MouseDoubleClick"
                   AutoGeneratingColumn="DataGridBooks_AutoGeneratingColumn"
                   Style="{DynamicResource DataGridStyle}"
                   ItemsSource="{Binding AllBooks}">
                </DataGrid>
            </Grid>

            <Grid Grid.Row="2">

                <Grid.ColumnDefinitions>
                    <ColumnDefinition Width="*"/>
                    <ColumnDefinition Width="*"/>
                </Grid.ColumnDefinitions>

                <Grid Grid.Column="0" HorizontalAlignment="Left">
                    <StackPanel 
                       Margin="0 10"
                       HorizontalAlignment="Center"
                       Orientation="Horizontal">

                        <TextBlock
                           Margin="10"
                           Text="Filter"
                           FontSize="30"
                           Foreground="{DynamicResource TextPrimaryColor}" 
                           FontWeight="Bold" >

                        </TextBlock>

                        <TextBox x:Name="TextBoxFilter"
                           Width="270"
                           Height="45"
                           FontFamily="Poppins" 
                           FontSize="20" 
                           Padding="9" 
                           Foreground="{DynamicResource PrimaryBlueColor}" 
                           TextChanged="FilterBox_TextChanged"/>

                    </StackPanel>
                </Grid>

                <Grid Grid.Column="1" HorizontalAlignment="Right">
                    <Button
                       Style="{DynamicResource ButtonAddStyle}"
                       Click="ButtonPlus_Click">
                        <StackPanel Orientation="Horizontal">
                            <TextBlock
                                   VerticalAlignment="Center"
                                   Text="➕"
                                   FontSize="30"
                                   Foreground="{DynamicResource TextPrimaryColor}" 
                                   FontWeight="Bold">
                            </TextBlock>

                            <Image Source="..\Resources\bookportrait.png" Stretch="Uniform" Margin="2"/>
                        </StackPanel>
                    </Button>
                </Grid>
            </Grid>

        </Grid>
    </Border>
</Page>
```

BooksPage.xaml.cs

```cs
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;
using System.Windows.Navigation;

using LIBGL.ViewModels;

namespace LIBGL.Pages
{
    public partial class BooksPage : Page
    {
        private readonly BooksPageViewModel _viewModel;
        public BooksPage()
        {
            InitializeComponent();
            _viewModel = new BooksPageViewModel();
            DataContext = _viewModel;
        }

        private void DataGridBooks_MouseDoubleClick(object sender, MouseButtonEventArgs e)
        {
            if (sender is not DataGrid grid || grid.SelectedItem is not Models.Book || grid.SelectedItems.Count != 1)
            {
                return;
            }

            Models.Book? selectedBook = grid.SelectedItem as Models.Book;
            DataGridBooks.UnselectAll();
            NavigationService.Navigate(ChildPage(selectedBook));
        }

        private void ButtonPlus_Click(object sender, RoutedEventArgs e)
        {
            NavigationService.Navigate(ChildPage(new Models.Book()));
        }

        private BookDetailPage ChildPage(Models.Book? book)
        {
            book ??= new Models.Book();

            BookDetailsViewModel childViewModel = new BookDetailsViewModel(_viewModel, book);
            BookDetailPage? childPage = new BookDetailPage(childViewModel);
            return childPage;
        }

        private void FilterBox_TextChanged(object sender, TextChangedEventArgs e)
        {
            if (sender is not TextBox filterBox)
            {
                return;
            }

            _viewModel.FilterBooks(filterBox.Text);
        }

        private void DataGridBooks_AutoGeneratingColumn(object sender, DataGridAutoGeneratingColumnEventArgs e)
        {
            if (e.PropertyName == "BookId")
            {
                e.Cancel = true;
            }

            if (e.PropertyName == "BookTypeId")
            {
                e.Cancel = true;
            }

            if (e.PropertyName == "PublisherId")
            {
                e.Cancel = true;
            }

            if (e.PropertyName == "Stock")
            {
                e.Column.Width = 120;
            }

            if (e.PropertyName == "PublishYear")
            {
                e.Column.Width = 120;
            }

            if (e.PropertyName == "Active")
            {
                e.Cancel = true;
            }
        }
    }
}
```

BooksPageViewModel.cs

```cs
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Windows.Data;

using LIBGL.Databases;
using LIBGL.Utils;

namespace LIBGL.ViewModels
{
    public class BooksPageViewModel : ViewModelBase
    {
        private string _title;
        public string Title
        {
            get
            {
                return _title;
            }
            set
            {
                _title = value;
                OnPropertyChanged(nameof(Title));
            }
        }

        private List<Models.Book> _books;
        public List<Models.Book> Books
        {
            get
            {
                return _books;
            }
            set
            {
                _books = value;
                OnPropertyChanged(nameof(Books));
            }
        }

        private readonly ObservableCollection<Models.Book> _allBooks;
        public ObservableCollection<Models.Book> AllBooks
        {
            get => _allBooks;
            set
            {
                OnPropertyChanged(nameof(AllBooks));
            }
        }

        public ICollectionView BooksView { get; private set; }

        public BooksPageViewModel()
        {
            _title = Consts.BOOKS_PAGE_TITLE;
            _books = DbUtils.GetAllActiveBooks();
            _allBooks = new ObservableCollection<Models.Book>(Books);
            BooksView = CollectionViewSource.GetDefaultView(_allBooks);
        }

        public void FilterBooks(string inputText)
        {
            inputText = inputText.ToLower();

            BooksView.Filter = book =>
            {
                return ((Models.Book)book).Title.ToLower().Contains(inputText)
                || ((Models.Book)book).PublishYear.ToString().ToLower().Contains(inputText)
                || ((Models.Book)book).Stock.ToString().ToLower().Contains(inputText);
            };
        }
    }
}
```

BookDetailPage.xaml

```xml
<Page x:Class="LIBGL.Pages.BookDetailPage"
      xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
      xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
      xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006" 
      xmlns:d="http://schemas.microsoft.com/expression/blend/2008" 
      xmlns:local="clr-namespace:LIBGL.Pages"
      xmlns:vms="clr-namespace:LIBGL.ViewModels" 
      d:DataContext="{d:DesignInstance Type=vms:BookDetailsViewModel}"
      mc:Ignorable="d" 
      d:DesignHeight="900" d:DesignWidth="1600"
      Title="BookDetailPage">

    <Border CornerRadius="5" Background="{DynamicResource BackgroundSecondaryColor}">

        <Grid>

            <Grid.RowDefinitions>
                <RowDefinition Height="Auto"/>
                <RowDefinition Height="Auto"/>
            </Grid.RowDefinitions>

            <Grid Grid.Row="0" HorizontalAlignment="Center" Margin="20">
                <TextBlock x:Name="BookDetailsHeader"
                   Text="Edit Book Details" 
                   FontSize="50" 
                   Foreground="{DynamicResource TextPrimaryColor}" 
                   FontWeight="Bold" 
                   VerticalAlignment="Center" 
                   HorizontalAlignment="Center"/>
            </Grid>

            <Grid Grid.Row="1" VerticalAlignment="Center" HorizontalAlignment="Center">

                <Grid.ColumnDefinitions>
                    <ColumnDefinition Width="Auto"/>
                    <ColumnDefinition Width="Auto"/>
                    <ColumnDefinition Width="Auto"/>
                </Grid.ColumnDefinitions>


                <Grid Grid.Column="0">

                    <Grid.RowDefinitions>
                        <RowDefinition Height="Auto"/>
                        <RowDefinition Height="Auto"/>
                    </Grid.RowDefinitions>

                    <Border 
                       Width="270" 
                       Height="480" 
                       CornerRadius="3" 
                       Margin="32 32 32 0" 
                       BorderThickness="9" 
                       BorderBrush="{DynamicResource TextPrimaryColor}">
                        <Image 
                       Source="../Resources/book.png" 
                       Stretch="UniformToFill"/>
                    </Border>

                    <StackPanel Grid.Row="1" Width="270">
                        <TextBlock 
                               Text="Title" 
                               FontSize="20" 
                               Foreground="{DynamicResource TextPrimaryColor}" 
                               FontWeight="Bold" 
                               HorizontalAlignment="Center"/>
                        <TextBox Name="TextBoxBookTitle" 
                                    Text="{Binding BookTitleBoxText, UpdateSourceTrigger=PropertyChanged}" 
                                    FontFamily="Poppins" 
                                    FontSize="16" 
                                    Padding="5" 
                                    Margin="5" 
                                    Foreground="{DynamicResource PrimaryBlueColor}" 
                                    PreviewTextInput="PrimaryInputLimit_PreviewTextInput"/>
                    </StackPanel>
                </Grid>

                <Grid Grid.Column="1">

                    <Grid.RowDefinitions>
                        <RowDefinition Height="*"/>
                        <RowDefinition Height="Auto"/>
                    </Grid.RowDefinitions>

                    <WrapPanel Grid.Row="0" Grid.Column="1" Orientation="Vertical">

                        <StackPanel Margin="0 32 0 32" Width="270">
                            <TextBlock 
                                Text="Authors list" 
                                FontSize="20" 
                                Foreground="{DynamicResource TextPrimaryColor}" 
                                FontWeight="Bold" 
                                HorizontalAlignment="Left"/>
                            <ComboBox 
                                Margin="0 9 0 0" 
                                FontSize="16" 
                                ItemsSource="{Binding UncheckedAuthors, UpdateSourceTrigger=PropertyChanged}">
                                <ComboBox.ItemTemplate>
                                    <DataTemplate>
                                        <CheckBox Content="{Binding}" Click="CheckBoxCheckAuthor_Click"/>
                                    </DataTemplate>
                                </ComboBox.ItemTemplate>
                            </ComboBox>

                        </StackPanel>

                        <StackPanel Margin="0 0 0 32" Width="270">
                            <TextBlock 
                                Text="Genres list" 
                                FontSize="20" 
                                Foreground="{DynamicResource TextPrimaryColor}" 
                                FontWeight="Bold" 
                                HorizontalAlignment="Left"/>
                            <ComboBox 
                                SelectedItem="{Binding BookGenreSelectedItem}" 
                                ItemsSource="{Binding AllBookGenresNames}" 
                                FontFamily="Poppins" 
                                FontSize="16" 
                                Padding="5" 
                                Margin="0 9 0 0" 
                                Foreground="{DynamicResource PrimaryBlueColor}"/>
                        </StackPanel>

                        <StackPanel Margin="0 0 0 32" Width="270">
                            <TextBlock 
                                Text="Publishers list" 
                                FontSize="20" 
                                Foreground="{DynamicResource TextPrimaryColor}" 
                                FontWeight="Bold" 
                                HorizontalAlignment="Left"/>
                            <ComboBox 
                                SelectedItem="{Binding BookPublisherSelectedItem}" 
                                ItemsSource="{Binding AllBookPublishersNames}" 
                                FontFamily="Poppins" 
                                FontSize="16" 
                                Padding="5" 
                                Margin="0 9 0 0" 
                                Foreground="{DynamicResource PrimaryBlueColor}"/>
                        </StackPanel>

                        <StackPanel Margin="0 0 0 32" Width="270">
                            <TextBlock 
                               Text="Stock amount" 
                               FontSize="20" 
                               Foreground="{DynamicResource TextPrimaryColor}" 
                               FontWeight="Bold" 
                               HorizontalAlignment="Left"/>
                            <TextBox Name="TextBoxBookStock" 
                                    Text="{Binding BookStockBoxText, UpdateSourceTrigger=PropertyChanged}" 
                                    FontFamily="Poppins" 
                                    FontSize="16" 
                                    Padding="5" 
                                    Margin="0 9 0 0" 
                                    Foreground="{DynamicResource PrimaryBlueColor}" 
                                    PreviewTextInput="SecondaryInputLimit_PreviewTextInput"/>
                        </StackPanel>

                        <StackPanel Margin="0 0 0 32" Width="270">
                            <TextBlock 
                               Text="Publish year" 
                               FontSize="20" 
                               Foreground="{DynamicResource TextPrimaryColor}" 
                               FontWeight="Bold" 
                               HorizontalAlignment="Left"/>
                            <TextBox Name="TextBoxPublishYear" 
                                    Text="{Binding BookPublishYearBoxText, UpdateSourceTrigger=PropertyChanged}" 
                                    FontFamily="Poppins" 
                                    FontSize="16" 
                                    Padding="5" 
                                    Margin="0 9 0 0" 
                                    Foreground="{DynamicResource PrimaryBlueColor}" 
                                    PreviewTextInput="SecondaryInputLimit_PreviewTextInput"/>
                        </StackPanel>

                    </WrapPanel>

                    <StackPanel Grid.Row="1" Orientation="Horizontal">
                        <Button x:Name="ButtonSave"
                           Content="Save" 
                           Style="{DynamicResource ButtonSaveStyle}" 
                           Click="ButtonSave_Click" 
                           IsEnabled="{Binding CanClickSaveButton}">

                        </Button>

                        <Button 
                           Content="Cancel" 
                           Style="{DynamicResource ButtonCancelStyle}" 
                           Click="ButtonCancel_Click">

                        </Button>

                        <Button x:Name="ButtonDelete"
                           Content="🗑️" 
                           Style="{DynamicResource ButtonDeleteStyle}" 
                           Click="ButtonDelete_Click">

                        </Button>
                    </StackPanel>
                </Grid>

                <Grid Grid.Column="2">
                    <StackPanel Width="270" Margin="32" Height="Auto" MaxHeight="570">

                        <TextBlock 
                                Text="Selected Authors" 
                                FontSize="20" 
                                Foreground="{DynamicResource TextPrimaryColor}" 
                                FontWeight="Bold" 
                                HorizontalAlignment="Center"/>

                        <ListBox 
                            ItemsSource="{Binding CheckedAuthors, UpdateSourceTrigger=PropertyChanged}">
                            <ListBox.ItemTemplate>
                                <DataTemplate>
                                    <CheckBox Content="{Binding}" Click="CheckBoxUncheckAuthor_Click"/>
                                </DataTemplate>
                            </ListBox.ItemTemplate>
                        </ListBox>
                    </StackPanel>
                </Grid>

            </Grid>

        </Grid>

    </Border>
</Page>

```

BookDetailPage.xaml.cs

```cs
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;
using System.Windows.Navigation;

using LIBGL.Databases;
using LIBGL.Models;
using LIBGL.Utils;
using LIBGL.ViewModels;

namespace LIBGL.Pages
{
    public partial class BookDetailPage : Page
    {
        private readonly Models.Book _book;
        public BookDetailsViewModel BookDetailsViewModel { get; }

        public BookDetailPage(BookDetailsViewModel bookDetailsViewModel)
        {
            InitializeComponent();
            BookDetailsViewModel = bookDetailsViewModel;
            DataContext = BookDetailsViewModel;

            _book = bookDetailsViewModel.Book;

            if (_book.BookId.Equals(int.MinValue))
            {
                ButtonDelete.Visibility = Visibility.Hidden;
                ButtonSave.Content = Consts.ADD_TEXT;
                BookDetailsHeader.Text = Consts.BOOK_ADD_TEXT;
            }
        }

        private void ButtonSave_Click(object sender, RoutedEventArgs e)
        {
            if (sender is not Button)
            {
                return;
            }

            Models.Book book = new Models.Book
            {
                BookId = _book.BookId,
                Title = TextBoxBookTitle.Text,
                BookTypeId = BookTypeIdFrom(BookDetailsViewModel.BookGenreSelectedItem),
                PublisherId = PublisherIdFrom(BookDetailsViewModel.BookPublisherSelectedItem),
                Stock = Convert.ToInt32(BookDetailsViewModel.BookStockBoxText),
                PublishYear = Convert.ToInt32(BookDetailsViewModel.BookPublishYearBoxText),
                Active = _book.Active,
            };

            if (book.BookId.Equals(int.MinValue))
            {
                book.BookId = DbUtils.InsertBook(book);
            }
            else
            {
                DbUtils.UpdateBook(book);
            }

            List<Models.Author> currentBooksAuthors = BookDetailsViewModel.CurrentBooksAuthors;
            List<Models.AuthorBook> authorBooks = new List<Models.AuthorBook>();
            int orderValue = 1;

            foreach (Models.Author author in currentBooksAuthors)
            {
                Models.AuthorBook authorBook = new Models.AuthorBook
                {
                    AuthorId = author.AuthorId,
                    BookId = book.BookId,
                    NumberInList = orderValue,
                };

                authorBooks.Add(authorBook);
                orderValue++;
            }

            foreach (Models.AuthorBook authorBook in authorBooks)
            {
                DbUtils.InsertAuthorBook(authorBook);
            }

            NavigationService.Navigate(new BooksPage());
        }

        private void ButtonCancel_Click(object sender, RoutedEventArgs e)
        {
            if (sender is not Button)
            {
                return;
            }

            NavigationService.Navigate(new BooksPage());
        }

        private void ButtonDelete_Click(object sender, RoutedEventArgs e)
        {
            if (sender is not Button)
            {
                return;
            }

            DbUtils.DeleteBook(_book.BookId);

            NavigationService.Navigate(new BooksPage());
        }

        private void CheckBoxCheckAuthor_Click(object sender, RoutedEventArgs e)
        {
            if (sender is not CheckBox checkBox)
            {
                return;
            }

            if (checkBox.Content is null)
            {
                return;
            }

            string authorName = checkBox.Content as string ?? "N/A";

            BookDetailsViewModel.CheckedAuthors.Add(authorName);
            BookDetailsViewModel.UncheckedAuthors.Remove(authorName);
            BookDetailsViewModel.CurrentBooksAuthors.Add(AuthorFindBy(authorName));
        }

        private void CheckBoxUncheckAuthor_Click(object sender, RoutedEventArgs e)
        {
            if (sender is not CheckBox checkBox)
            {
                return;
            } 

            if (checkBox.Content is null)
            {
                return;
            }

            string authorName = checkBox.Content as string ?? "N/A";

            BookDetailsViewModel.UncheckedAuthors.Add(authorName);
            BookDetailsViewModel.CheckedAuthors.Remove(authorName);
            BookDetailsViewModel.CurrentBooksAuthors.Remove(AuthorFindBy(authorName));
        }

        private void PrimaryInputLimit_PreviewTextInput(object sender, TextCompositionEventArgs e)
        {
            if (sender is not TextBox textBox)
            {
                return;
            }

            if (textBox.Text.Length >= Consts.TEXTBOX_PRIMARY_LIMIT)
            {
                e.Handled = true;
            }
        }

        private void SecondaryInputLimit_PreviewTextInput(object sender, TextCompositionEventArgs e)
        {
            if (sender is not TextBox textBox)
            {
                return;
            }

            if (textBox.Text.Length >= Consts.TEXTBOX_SECONDARY_LIMIT)
            {
                e.Handled = true;
            }
        }

        private void TertiaryInputLimit_PreviewTextInput(object sender, TextCompositionEventArgs e)
        {
            if (sender is not TextBox textBox)
            {
                return;
            }

            if (textBox.Text.Length >= Consts.TEXTBOX_TERTIARY_LIMIT)
            {
                e.Handled = true;
            }
        }

        private int BookTypeIdFrom(string genreName)
        {
            foreach (Models.BookType bookType in BookDetailsViewModel.BookGenres)
            {
                if (bookType.Name == genreName)
                {
                    return bookType.BookTypeId;
                }
            }

            return -1;
        }

        private int PublisherIdFrom(string publisherName)
        {
            foreach (Models.Publisher publisher in BookDetailsViewModel.BookPublishers)
            {
                if (publisher.Name == publisherName)
                {
                    return publisher.PublisherId;
                }
            }

            return -1;
        }

        private Author AuthorFindBy(string authorName)
        {
            foreach (Models.Author author in BookDetailsViewModel.BookAuthors)
            {
                if (author.LastName == authorName)
                {
                    return author;
                }
            }

            return new Author();
        }
    }
}
```

BookDetailsViewModel.cs

```cs
using Microsoft.IdentityModel.Tokens;
using System.Collections.ObjectModel;

using LIBGL.Databases;
using LIBGL.Models;

namespace LIBGL.ViewModels
{
    public class BookDetailsViewModel : ViewModelBase
    {
        private readonly BooksPageViewModel _parent;

        private Models.Book _book;
        public Models.Book Book
        {
            get
            {
                return _book;
            }
            set
            {
                _book = value;
                OnPropertyChanged(nameof(Book));
            }
        }

        private string _bookTitleBoxText;
        public string BookTitleBoxText
        {
            get
            {
                return _bookTitleBoxText;
            }
            set
            {
                _bookTitleBoxText = value;
                OnPropertyChanged(nameof(BookTitleBoxText));
                UpdateCanClickSaveButton();
            }
        }

        private readonly List<Models.Author> _bookAuthors;
        public List<Models.Author> BookAuthors 
        { 
            get
            {
                return _bookAuthors;
            }
        }

        private readonly List<Models.Author> _currentBooksAuthors;
        public List<Models.Author> CurrentBooksAuthors
        {
            get
            {
                return _currentBooksAuthors;
            }
        }

        private readonly List<Models.BookType> _bookGenres;
        public List<Models.BookType> BookGenres
        {
            get
            {
                return _bookGenres;
            }
        }

        private readonly List<Models.Publisher> _bookPublishers;
        public List<Models.Publisher> BookPublishers
        {
            get
            {
                return _bookPublishers;
            }
        }

        public List<string> AllAuthorsLastNames { get; }

        public List<string> AllBookGenresNames { get; }

        public List<string> AllBookPublishersNames { get; }

        private bool _canClickSaveButton;
        public bool CanClickSaveButton
        {
            get { return _canClickSaveButton; }
            set
            {
                _canClickSaveButton = value;
                OnPropertyChanged(nameof(CanClickSaveButton));
            }
        }

        private ObservableCollection<string> _checkedAuthors;
        public ObservableCollection<string> CheckedAuthors
        {
            get => _checkedAuthors;
            set
            {
                _checkedAuthors = value;
                OnPropertyChanged(nameof(CheckedAuthors));
                UpdateCanClickSaveButton();
            }
        }

        private ObservableCollection<string> _uncheckedAuthors;
        public ObservableCollection<string> UncheckedAuthors
        {
            get => _uncheckedAuthors;
            set
            {
                _uncheckedAuthors = value;
                OnPropertyChanged(nameof(UncheckedAuthors));
                UpdateCanClickSaveButton();
            }
        }

        private string _bookGenreSelectedItem;
        public string BookGenreSelectedItem
        {
            get
            {
                return _bookGenreSelectedItem;
            }
            set
            {
                _bookGenreSelectedItem = value;
                OnPropertyChanged(nameof(BookGenreSelectedItem));
                UpdateCanClickSaveButton();
            }
        }

        private string _bookPublisherSelectedItem;
        public string BookPublisherSelectedItem
        {
            get
            {
                return _bookPublisherSelectedItem;
            }
            set
            {
                _bookPublisherSelectedItem = value;
                OnPropertyChanged(nameof(BookPublisherSelectedItem));
                UpdateCanClickSaveButton();
            }
        }
        private string _bookStockBoxText;
        public string BookStockBoxText
        {
            get
            {
                return _bookStockBoxText;
            }
            set
            {
                _bookStockBoxText = value;
                OnPropertyChanged(nameof(BookStockBoxText));
                UpdateCanClickSaveButton();
            }
        }

        private string _bookPublishYearBoxText;
        public string BookPublishYearBoxText
        {
            get
            {
                return _bookPublishYearBoxText;
            }
            set
            {
                _bookPublishYearBoxText = value;
                OnPropertyChanged(nameof(BookPublishYearBoxText));
                UpdateCanClickSaveButton();
            }
        }

        public BookDetailsViewModel(BooksPageViewModel parent, Models.Book book)
        {
            _book = book;
            _parent = parent;

            if (book.BookId.Equals(int.MinValue)) 
            {
                _bookAuthors = DbUtils.GetAllActiveAuthors();
                _bookGenres = DbUtils.GetAllActiveBookGenres();
                _bookPublishers = DbUtils.GetAllActivePublishers();
                _currentBooksAuthors = new List<Author>();
            } 
            else
            {
                _bookAuthors = DbUtils.GetAllAuthors();
                _bookGenres = DbUtils.GetAllBookGenres();
                _bookPublishers = DbUtils.GetAllPublishers();
                _currentBooksAuthors = DbUtils.GetBookAuthorsOf(book);
            }

            _bookTitleBoxText = book.Title;
            _bookGenreSelectedItem = string.Empty;
            _bookPublisherSelectedItem = string.Empty;
            _bookStockBoxText = book.Stock.ToString();
            _bookPublishYearBoxText = book.PublishYear.ToString();

            AllAuthorsLastNames = new List<string>();
            AllBookGenresNames = new List<string>();
            AllBookPublishersNames = new List<string>();

            _uncheckedAuthors = new ObservableCollection<string>();
            _checkedAuthors = new ObservableCollection<string>();

            foreach (Models.Author author in _bookAuthors)
            {
                if (_currentBooksAuthors.Find(target => target.AuthorId == author.AuthorId) != null)
                {
                    _checkedAuthors.Add(author.LastName);
                }
                else
                {
                    _uncheckedAuthors.Add(author.LastName);
                }

                AllAuthorsLastNames.Add(author.LastName);
            }

            foreach (Models.BookType genre in _bookGenres)
            {

                if (genre.BookTypeId == book.BookTypeId)
                {
                    _bookGenreSelectedItem = genre.Name;
                }

                AllBookGenresNames.Add(genre.Name);
            }

            foreach (Models.Publisher publisher in _bookPublishers)
            {

                if (publisher.PublisherId == book.PublisherId)
                {
                    _bookPublisherSelectedItem = publisher.Name;
                }

                AllBookPublishersNames.Add(publisher.Name);
            }

            _canClickSaveButton = !string.IsNullOrEmpty(book.Title);
        }

        private void UpdateCanClickSaveButton()
        {
            CanClickSaveButton = !string.IsNullOrEmpty(BookTitleBoxText)
                && !CheckedAuthors.IsNullOrEmpty()
                && !string.IsNullOrEmpty(BookGenreSelectedItem)
                && !string.IsNullOrEmpty(BookPublisherSelectedItem)
                && !string.IsNullOrEmpty(BookStockBoxText)
                && !string.IsNullOrEmpty(BookPublishYearBoxText);
        }
    }
}

```

DarkTheme.xaml

```xml
<ResourceDictionary xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
                    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml">

    <!-- Background Colors -->
    <SolidColorBrush x:Key="BackgroundPrimaryColor" Color="#131725"/>
    <SolidColorBrush x:Key="BackgroundSecondaryColor" Color="#1d2335"/>

    <!-- Primary Colors -->
    <SolidColorBrush x:Key="PrimaryLightColor" Color="#F5F5F5"/>
    <SolidColorBrush x:Key="SecondaryLightColor" Color="#E0F7FF"/>


    <SolidColorBrush x:Key="PrimaryBlueColor" Color="#3772FF"/>
    <SolidColorBrush x:Key="SecondaryBlueColor" Color="#005FB0"/>
    <SolidColorBrush x:Key="TertiaryBlueColor" Color="#003F92"/>

    <SolidColorBrush x:Key="PrimaryRedColor" Color="#E51515"/>
    <SolidColorBrush x:Key="SecondaryRedColor" Color="#C23456"/>
    <SolidColorBrush x:Key="TertiaryRedColor" Color="#FF1122"/>

    <SolidColorBrush x:Key="PrimaryGrayColor" Color="#808080"/>
    <SolidColorBrush x:Key="SecondaryGrayColor" Color="#A1B2C3"/>
    <SolidColorBrush x:Key="TertiaryGrayColor" Color="#4D4D4D"/>

    <SolidColorBrush x:Key="PrimaryDarkColor" Color="#3D3D3D"/>
    <SolidColorBrush x:Key="SecondaryDarkColor" Color="#2C2C2C"/>
    <SolidColorBrush x:Key="TertiaryDarkColor" Color="#1D1D1D"/>


    <!-- Typograhy Colors -->
    <SolidColorBrush x:Key="TextPrimaryColor" Color="#FFFFFF"/>
    <SolidColorBrush x:Key="TextSecondaryColor" Color="#B0B7C3"/>
    <SolidColorBrush x:Key="TextTertiaryColor" Color="#8A94A6"/>
    <SolidColorBrush x:Key="TextQuarternaryColor" Color="#4B5D78"/>

    <!-- Icon Colors -->
    <SolidColorBrush x:Key="IconPrimaryColor" Color="#B0B7C3"/>
    <SolidColorBrush x:Key="IconSecondaryColor" Color="#8A94A6"/>
    <SolidColorBrush x:Key="IconTertiaryColor" Color="#4B5D78"/>
    <SolidColorBrush x:Key="IconQuarternaryColor" Color="#323B4B"/>

    <SolidColorBrush x:Key="ButtonCloseColor" Color="#F72626"/>

</ResourceDictionary>
```

Styles.xaml

```xml
<ResourceDictionary xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
                    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml">

    <!-- Start: Pop-up Button Style -->
    <Style x:Key="PopupButtonStyle" TargetType="{x:Type Button}">
        <Setter Property="Background" Value="Transparent"/>
        <Setter Property="BorderBrush" Value="Transparent"/>
        <Setter Property="Foreground" Value="Transparent"/>
        <Setter Property="BorderThickness" Value="0"/>
        <Setter Property="HorizontalContentAlignment" Value="Center"/>
        <Setter Property="VerticalContentAlignment" Value="Center"/>
        <Setter Property="Padding" Value="0"/>
        <Setter Property="Height" Value="50"/>
        <Setter Property="Template">
            <Setter.Value>
                <ControlTemplate TargetType="{x:Type Button}">
                    <Border x:Name="border"
                                BorderBrush="{TemplateBinding BorderBrush}"
                                BorderThickness="{TemplateBinding BorderThickness}"
                                Background="{TemplateBinding Background}"
                                SnapsToDevicePixels="true">
                        <ContentPresenter x:Name="contentPresenter"
                                              Focusable="False"
                                              RecognizesAccessKey="True"
                                              SnapsToDevicePixels="{TemplateBinding SnapsToDevicePixels}"
                                              VerticalAlignment="{TemplateBinding VerticalContentAlignment}"
                                              HorizontalAlignment="{TemplateBinding HorizontalContentAlignment}"
                                              Margin="{TemplateBinding Padding}"/>
                    </Border>
                    <ControlTemplate.Triggers>
                        <Trigger Property="IsMouseOver" Value="True">
                            <Setter Property="Background" Value="Transparent"/>
                            <Setter Property="BorderBrush" Value="Transparent"/>
                        </Trigger>
                        <Trigger Property="IsPressed" Value="True">
                            <Setter Property="Background" Value="Transparent"/>
                            <Setter Property="BorderBrush" Value="Transparent"/>
                        </Trigger>
                    </ControlTemplate.Triggers>
                </ControlTemplate>
            </Setter.Value>
        </Setter>
    </Style>
    <!-- End: Pop-up Button Style -->

    <!-- Start: iToggleButton Style -->
    <Style x:Key="IToggleButtonStyle" TargetType="{x:Type ToggleButton}">
        <Setter Property="Width" Value="30"/>
        <Setter Property="Height" Value="30"/>
        <Setter Property="Template">
            <Setter.Value>
                <ControlTemplate TargetType="{x:Type ToggleButton}">
                    <Border x:Name="border" BorderThickness="{TemplateBinding BorderThickness}" Background="{TemplateBinding Background}" SnapsToDevicePixels="True">
                        <Viewbox Height="20" Width="20" Margin="0 6 0 0" Stretch="UniformToFill">
                            <Canvas Height="512" Width="512">
                                <Path Data="m32 0h448c17.671875 0 32 14.328125 32 32s-14.328125 32-32 32h-448c-17.671875 0-32-14.328125-32-32s14.328125-32 32-32zm0 0" Fill="{DynamicResource IconSecondaryColor}" Margin="0 0 0 0"/>
                                <Path Data="m32 128h448c17.671875 0 32 14.328125 32 32s-14.328125 32-32 32h-448c-17.671875 0-32-14.328125-32-32s14.328125-32 32-32zm0 0" Fill="{DynamicResource IconSecondaryColor}" Margin="0 20 0 0"/>
                                <Path Data="m32 256h448c17.671875 0 32 14.328125 32 32s-14.328125 32-32 32h-448c-17.671875 0-32-14.328125-32-32s14.328125-32 32-32zm0 0" Fill="{DynamicResource IconSecondaryColor}" Margin="0 40 0 0"/>
                            </Canvas>
                        </Viewbox>
                    </Border>
                    <ControlTemplate.Triggers>

                        <Trigger Property="IsMouseOver" Value="true">
                            <Setter Property="Background"
                                        TargetName="border"
                                        Value="Transparent"/>
                            <Setter Property="BorderBrush"
                                        TargetName="border"
                                        Value="#FFFFFF"/>
                        </Trigger>
                        <Trigger Property="IsChecked" Value="true">
                            <Setter Property="Background"
                                        TargetName="border"
                                        Value="Transparent"/>
                            <Setter Property="BorderBrush"
                                        TargetName="border"
                                       Value="#FFFFFF"/>
                        </Trigger>
                    </ControlTemplate.Triggers>
                </ControlTemplate>
            </Setter.Value>
        </Setter>
    </Style>
    <!-- End: iToggleButton Style -->

    <!-- Start: Button Close | Restore | Minimize -->
    <Style x:Key="IconButtonsStyle" TargetType="{x:Type Button}">
        <Setter Property="Background" Value="Transparent"/>
        <Setter Property="Cursor" Value="Hand"/>
        <Setter Property="BorderThickness" Value="0"/>
        <Setter Property="Height" Value="25"/>
        <Setter Property="Width" Value="25"/>
        <Setter Property="Template">
            <Setter.Value>
                <ControlTemplate TargetType="{x:Type Button}">
                    <Border Name="bd" CornerRadius="5" Background="{TemplateBinding Background}" BorderThickness="{TemplateBinding BorderThickness}">
                        <Path Name="ico" Data="{TemplateBinding Content}" Fill="{DynamicResource TextPrimaryColor}" Height="10" Width="10" Stretch="Uniform"/>
                    </Border>
                    <ControlTemplate.Triggers>
                        <Trigger Property="IsMouseOver" Value="True">
                            <Setter Property="Background" Value="{DynamicResource BackgroundSecondaryColor}"/>
                        </Trigger>
                        <MultiTrigger>
                            <MultiTrigger.Conditions>
                                <Condition Property="IsMouseOver" Value="True"/>
                                <Condition Property="Tag" Value="IsCloseButton"/>
                            </MultiTrigger.Conditions>
                            <Setter Property="Background" Value="{DynamicResource ButtonCloseColor}"/>
                            <Setter TargetName="ico" Property="Fill" Value="{DynamicResource TextPrimaryColor}"/>
                        </MultiTrigger>
                        <Trigger Property="IsPressed" Value="True">
                            <Setter TargetName="ico" Property="Fill" Value="{DynamicResource TextPrimaryColor}"/>
                        </Trigger>
                    </ControlTemplate.Triggers>
                </ControlTemplate>
            </Setter.Value>
        </Setter>
    </Style>
    <!-- End: Button Close | Restore | Minimize -->

    <!-- Start: Data Grid-->
    <Style x:Key="DashboardDataGridStyle" TargetType="DataGrid">
        <Setter Property="FontFamily" Value="Poppins"/>
        <Setter Property="FontSize" Value="14"/>
        <Setter Property="Height" Value="180"/>
        <Setter Property="Width" Value="415"/>
        <Setter Property="Foreground" Value="{DynamicResource TextQuarternaryColor}"/>
        <Setter Property="Background" Value="{DynamicResource TextTertiaryColor}"/>
        <Setter Property="BorderBrush" Value="{DynamicResource TextSecondaryColor}"/>
        <Setter Property="BorderThickness" Value="1"/>
        <Setter Property="RowBackground" Value="{DynamicResource TextPrimaryColor}"/>
        <Setter Property="AutoGenerateColumns" Value="True"/>
        <Setter Property="IsReadOnly" Value="True"/>
        <Setter Property="ColumnWidth" Value="*"/>
    </Style>


    <Style x:Key="DataGridStyle" TargetType="DataGrid">
        <Setter Property="FontFamily" Value="Poppins"/>
        <Setter Property="FontSize" Value="20"/>
        <Setter Property="Height" Value="450"/>
        <Setter Property="Width" Value="950"/>
        <Setter Property="Foreground" Value="{DynamicResource TextQuarternaryColor}"/>
        <Setter Property="Background" Value="{DynamicResource TextTertiaryColor}"/>
        <Setter Property="BorderBrush" Value="{DynamicResource TextSecondaryColor}"/>
        <Setter Property="BorderThickness" Value="3"/>
        <Setter Property="RowBackground" Value="{DynamicResource TextPrimaryColor}"/>
        <Setter Property="AutoGenerateColumns" Value="True"/>
        <Setter Property="IsReadOnly" Value="True"/>
        <Setter Property="ColumnWidth" Value="*"/>
    </Style>

    <!-- End: Data Grid-->

    <Style x:Key="ButtonAddStyle" TargetType="Button">
        <Setter Property="Background" Value="{DynamicResource PrimaryGrayColor}"/>
        <Setter Property="Height" Value="54"/>
        <Setter Property="Width" Value="108"/>
        <Setter Property="Cursor" Value="Hand"/>
        <Setter Property="BorderThickness" Value="0"/>
        <Setter Property="HorizontalAlignment" Value="Center"/>
        <Setter Property="VerticalAlignment" Value="Center"/>
        <Setter Property="Template">
            <Setter.Value>
                <ControlTemplate TargetType="Button">
                    <Border x:Name="ButtonSaveBorder" Background="{TemplateBinding Background}"
                            BorderBrush="{TemplateBinding BorderBrush}"
                            BorderThickness="{TemplateBinding BorderThickness}"
                            CornerRadius="3">
                        <ContentPresenter HorizontalAlignment="Center"
                                          VerticalAlignment="Center"/>
                    </Border>
                    <ControlTemplate.Triggers>
                        <Trigger Property="IsMouseOver" Value="True">
                            <Setter TargetName="ButtonSaveBorder" Property="Background" Value="{DynamicResource SecondaryGrayColor}"/>
                        </Trigger>
                        <Trigger Property="IsPressed" Value="True">
                            <Setter TargetName="ButtonSaveBorder" Property="Background" Value="{DynamicResource SecondaryGrayColor}"/>
                        </Trigger>
                    </ControlTemplate.Triggers>
                </ControlTemplate>
            </Setter.Value>
        </Setter>
    </Style>

    <Style x:Key="ButtonSaveStyle" TargetType="Button">
        <Setter Property="Background" Value="{DynamicResource PrimaryBlueColor}"/>
        <Setter Property="Foreground" Value="{DynamicResource TextPrimaryColor}"/>
        <Setter Property="FontFamily" Value="Poppins"/>
        <Setter Property="FontSize" Value="20"/>
        <Setter Property="Padding" Value="10"/>
        <Setter Property="Margin" Value="5"/>
        <Setter Property="Height" Value="45"/>
        <Setter Property="Width" Value="80"/>
        <Setter Property="Cursor" Value="Hand"/>
        <Setter Property="BorderThickness" Value="0"/>
        <Setter Property="HorizontalAlignment" Value="Center"/>
        <Setter Property="VerticalAlignment" Value="Center"/>
        <Setter Property="Template">
            <Setter.Value>
                <ControlTemplate TargetType="Button">
                    <Border x:Name="ButtonSaveBorder" Background="{TemplateBinding Background}"
                            BorderBrush="{TemplateBinding BorderBrush}"
                            BorderThickness="{TemplateBinding BorderThickness}"
                            CornerRadius="3">
                        <ContentPresenter HorizontalAlignment="Center"
                                          VerticalAlignment="Center"/>
                    </Border>
                    <ControlTemplate.Triggers>
                        <Trigger Property="IsMouseOver" Value="True">
                            <Setter TargetName="ButtonSaveBorder" Property="Background" Value="{DynamicResource SecondaryBlueColor}"/>
                        </Trigger>
                        <Trigger Property="IsPressed" Value="True">
                            <Setter TargetName="ButtonSaveBorder" Property="Background" Value="{DynamicResource TertiaryBlueColor}"/>
                        </Trigger>
                        <Trigger Property="IsEnabled" Value="False">
                            <Setter TargetName="ButtonSaveBorder" Property="Background" Value="{DynamicResource PrimaryGrayColor}"/>
                        </Trigger>
                    </ControlTemplate.Triggers>
                </ControlTemplate>
            </Setter.Value>
        </Setter>
    </Style>

    <Style x:Key="ButtonCancelStyle" TargetType="Button">
        <Setter Property="Background" Value="{DynamicResource PrimaryRedColor}"/>
        <Setter Property="Foreground" Value="{DynamicResource TextPrimaryColor}"/>
        <Setter Property="FontFamily" Value="Poppins"/>
        <Setter Property="FontSize" Value="20"/>
        <Setter Property="Padding" Value="10"/>
        <Setter Property="Margin" Value="5"/>
        <Setter Property="Height" Value="45"/>
        <Setter Property="Width" Value="100"/>
        <Setter Property="BorderThickness" Value="0"/>
        <Setter Property="Cursor" Value="Hand"/>
        <Setter Property="HorizontalAlignment" Value="Center"/>
        <Setter Property="VerticalAlignment" Value="Center"/>
        <Setter Property="Template">
            <Setter.Value>
                <ControlTemplate TargetType="Button">
                    <Border x:Name="ButtonSaveBorder" Background="{TemplateBinding Background}"
                            BorderBrush="{TemplateBinding BorderBrush}"
                            BorderThickness="{TemplateBinding BorderThickness}"
                            CornerRadius="3">
                        <ContentPresenter HorizontalAlignment="Center"
                                          VerticalAlignment="Center"/>
                    </Border>
                    <ControlTemplate.Triggers>
                        <Trigger Property="IsMouseOver" Value="True">
                            <Setter TargetName="ButtonSaveBorder" Property="Background" Value="{DynamicResource SecondaryRedColor}"/>
                        </Trigger>
                        <Trigger Property="IsPressed" Value="True">
                            <Setter TargetName="ButtonSaveBorder" Property="Background" Value="{DynamicResource TertiaryRedColor}"/>
                        </Trigger>
                    </ControlTemplate.Triggers>
                </ControlTemplate>
            </Setter.Value>
        </Setter>
    </Style>

    <Style x:Key="ButtonDeleteStyle" TargetType="Button">
        <Setter Property="Background" Value="{DynamicResource PrimaryDarkColor}"/>
        <Setter Property="Foreground" Value="{DynamicResource TextPrimaryColor}"/>
        <Setter Property="FontFamily" Value="Poppins"/>
        <Setter Property="FontSize" Value="20"/>
        <Setter Property="Padding" Value="10"/>
        <Setter Property="Margin" Value="5"/>
        <Setter Property="Height" Value="45"/>
        <Setter Property="Width" Value="48"/>
        <Setter Property="BorderThickness" Value="0"/>
        <Setter Property="Cursor" Value="Hand"/>
        <Setter Property="HorizontalAlignment" Value="Center"/>
        <Setter Property="VerticalAlignment" Value="Center"/>
        <Setter Property="Template">
            <Setter.Value>
                <ControlTemplate TargetType="Button">
                    <Border x:Name="ButtonSaveBorder" Background="{TemplateBinding Background}"
                            BorderBrush="{TemplateBinding BorderBrush}"
                            BorderThickness="{TemplateBinding BorderThickness}"
                            CornerRadius="3">
                        <ContentPresenter HorizontalAlignment="Center"
                                          VerticalAlignment="Center"/>
                    </Border>
                    <ControlTemplate.Triggers>
                        <Trigger Property="IsMouseOver" Value="True">
                            <Setter TargetName="ButtonSaveBorder" Property="Background" Value="{DynamicResource SecondaryDarkColor}"/>
                        </Trigger>
                        <Trigger Property="IsPressed" Value="True">
                            <Setter TargetName="ButtonSaveBorder" Property="Background" Value="{DynamicResource TertiaryDarkColor}"/>
                        </Trigger>
                    </ControlTemplate.Triggers>
                </ControlTemplate>
            </Setter.Value>
        </Setter>
    </Style>

</ResourceDictionary>
```

SQL Stored Procedures

```sql

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spBookSelect]
	-- Add the parameters for the stored procedure here
	@BookId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT [BookId]
	,[Title]
	,[BookTypeId]
	,[PublisherId]
	,[Stock]
	,[PublishYear]
	,[Active]
	FROM [Book]
	WHERE [BookId] = @BookId
END
GO



SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spBookInsert]
	-- Add the parameters for the stored procedure here
	@Title NVARCHAR(50),
	@BookTypeId INT,
	@PublisherId INT,
	@Stock INT,
	@PublishYear INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO [Book] (
	[Title], 
	[BookTypeId], 
	[PublisherId], 
	[Stock], 
	[PublishYear])
	VALUES (@Title, @BookTypeId, @PublisherId, @Stock, @PublishYear);

	SELECT SCOPE_IDENTITY() AS BookId;
END
GO



SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spBookUpdate]
	-- Add the parameters for the stored procedure here
	@BookId INT,
	@BookTypeId INT,
	@PublisherId INT,
	@Title NVARCHAR(50),
	@PublishYear INT,
	@Stock INT,
	@Active BIT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE [Book] SET 
	[BookTypeId] = @BookTypeId,
	[PublisherId] = @PublisherId,
	[Title] = @Title,
	[PublishYear] = @PublishYear,
	[Stock] = @Stock,
	[Active] = @Active
	WHERE [BookId] = @BookId;
END
GO



SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spBookDelete]
	-- Add the parameters for the stored procedure here
	@BookId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE [Book] SET 
	[Active] = 0
	WHERE [BookId] = @BookId
END
GO



SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spAllActiveBooksSelect]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT TOP (1000) [BookId]
	,[Title]
	,[BookTypeId]
	,[PublisherId]
	,[Stock]
	,[PublishYear]
	,[Active]
	FROM [Book]
	WHERE [Active] = 1
END
GO



SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spBookAuthorSelect]
	-- Add the parameters for the stored procedure here
	@BookId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT [Author].AuthorId, [Author].FirstName, [Author].LastName, [Author].BirthDate, [Author].Active
	FROM [Author]
	INNER JOIN [AuthorBook] ON [Author].AuthorId = [AuthorBook].AuthorId
	WHERE [AuthorBook].BookId = @BookId
END
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spBorrowedBooksSelect]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT 
	[Book].BookId, 
	[Book].BookTypeId, 
	[Book].PublisherId, 
	[Book].Title,
	[Book].PublishYear,
	[Book].Stock,
	[Book].Active
	FROM [Book]
	INNER JOIN [UserBook] ON [Book].BookId = [UserBook].BookId
	WHERE [UserBook].Active = 1
END
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spBorrowerUsersSelect]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT 
	[User].UserId, 
	[User].FirstName, 
	[User].LastName, 
	[User].Email,
	[User].Phone,
	[User].Active
	FROM [User]
	INNER JOIN [UserBook] ON [User].UserId = [UserBook].UserId
	WHERE [UserBook].Active = 1
END
GO

```
