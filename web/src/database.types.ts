export type Json =
  | string
  | number
  | boolean
  | null
  | { [key: string]: Json | undefined }
  | Json[]

export type Database = {
  public: {
    Tables: {
      admins: {
        Row: {
          created_at: string
          game_id: number
          user_id: string
        }
        Insert: {
          created_at?: string
          game_id: number
          user_id: string
        }
        Update: {
          created_at?: string
          game_id?: number
          user_id?: string
        }
        Relationships: [
          {
            foreignKeyName: "admins_game_id_fkey"
            columns: ["game_id"]
            isOneToOne: false
            referencedRelation: "games"
            referencedColumns: ["id"]
          },
        ]
      }
      games: {
        Row: {
          created_at: string
          event_at: string | null
          id: number
          name: string
          starts_at: string | null
          state: Database["public"]["Enums"]["game_state"]
          witness_period: boolean
        }
        Insert: {
          created_at?: string
          event_at?: string | null
          id?: number
          name: string
          starts_at?: string | null
          state: Database["public"]["Enums"]["game_state"]
          witness_period?: boolean
        }
        Update: {
          created_at?: string
          event_at?: string | null
          id?: number
          name?: string
          starts_at?: string | null
          state?: Database["public"]["Enums"]["game_state"]
          witness_period?: boolean
        }
        Relationships: []
      }
      players: {
        Row: {
          created_at: string
          died_at: string | null
          game: number
          id: string
          kills: number
          name: string | null
          nfc_tag: string | null
          state: Database["public"]["Enums"]["player_state"]
          target: string | null
        }
        Insert: {
          created_at?: string
          died_at?: string | null
          game: number
          id: string
          kills?: number
          name?: string | null
          nfc_tag?: string | null
          state: Database["public"]["Enums"]["player_state"]
          target?: string | null
        }
        Update: {
          created_at?: string
          died_at?: string | null
          game?: number
          id?: string
          kills?: number
          name?: string | null
          nfc_tag?: string | null
          state?: Database["public"]["Enums"]["player_state"]
          target?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "players_game_fkey"
            columns: ["game"]
            isOneToOne: false
            referencedRelation: "games"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "players_target_fkey"
            columns: ["target"]
            isOneToOne: true
            referencedRelation: "players"
            referencedColumns: ["id"]
          },
        ]
      }
    }
    Views: {
      [_ in never]: never
    }
    Functions: {
      assign_targets: {
        Args: {
          game_id: number
        }
        Returns: undefined
      }
      eliminate_target: {
        Args: {
          target_nfc_tag: string
        }
        Returns: {
          created_at: string
          died_at: string | null
          game: number
          id: string
          kills: number
          name: string | null
          nfc_tag: string | null
          state: Database["public"]["Enums"]["player_state"]
          target: string | null
        }
      }
      get_admin_games_for_user: {
        Args: {
          user_id: string
        }
        Returns: number[]
      }
      get_target_info: {
        Args: Record<PropertyKey, never>
        Returns: {
          id: string
          name: string
          state: Database["public"]["Enums"]["player_state"]
          game: number
        }[]
      }
    }
    Enums: {
      game_state:
        | "unpublished"
        | "pre_registration"
        | "registration"
        | "active"
        | "duel_phase"
        | "completed"
        | "paused"
      player_state:
        | "pending_registration"
        | "active"
        | "eliminated"
        | "ineligible"
        | "half_eliminated"
    }
    CompositeTypes: {
      [_ in never]: never
    }
  }
}

type PublicSchema = Database[Extract<keyof Database, "public">]

export type Tables<
  PublicTableNameOrOptions extends
    | keyof (PublicSchema["Tables"] & PublicSchema["Views"])
    | { schema: keyof Database },
  TableName extends PublicTableNameOrOptions extends { schema: keyof Database }
    ? keyof (Database[PublicTableNameOrOptions["schema"]]["Tables"] &
        Database[PublicTableNameOrOptions["schema"]]["Views"])
    : never = never,
> = PublicTableNameOrOptions extends { schema: keyof Database }
  ? (Database[PublicTableNameOrOptions["schema"]]["Tables"] &
      Database[PublicTableNameOrOptions["schema"]]["Views"])[TableName] extends {
      Row: infer R
    }
    ? R
    : never
  : PublicTableNameOrOptions extends keyof (PublicSchema["Tables"] &
        PublicSchema["Views"])
    ? (PublicSchema["Tables"] &
        PublicSchema["Views"])[PublicTableNameOrOptions] extends {
        Row: infer R
      }
      ? R
      : never
    : never

export type TablesInsert<
  PublicTableNameOrOptions extends
    | keyof PublicSchema["Tables"]
    | { schema: keyof Database },
  TableName extends PublicTableNameOrOptions extends { schema: keyof Database }
    ? keyof Database[PublicTableNameOrOptions["schema"]]["Tables"]
    : never = never,
> = PublicTableNameOrOptions extends { schema: keyof Database }
  ? Database[PublicTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Insert: infer I
    }
    ? I
    : never
  : PublicTableNameOrOptions extends keyof PublicSchema["Tables"]
    ? PublicSchema["Tables"][PublicTableNameOrOptions] extends {
        Insert: infer I
      }
      ? I
      : never
    : never

export type TablesUpdate<
  PublicTableNameOrOptions extends
    | keyof PublicSchema["Tables"]
    | { schema: keyof Database },
  TableName extends PublicTableNameOrOptions extends { schema: keyof Database }
    ? keyof Database[PublicTableNameOrOptions["schema"]]["Tables"]
    : never = never,
> = PublicTableNameOrOptions extends { schema: keyof Database }
  ? Database[PublicTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Update: infer U
    }
    ? U
    : never
  : PublicTableNameOrOptions extends keyof PublicSchema["Tables"]
    ? PublicSchema["Tables"][PublicTableNameOrOptions] extends {
        Update: infer U
      }
      ? U
      : never
    : never

export type Enums<
  PublicEnumNameOrOptions extends
    | keyof PublicSchema["Enums"]
    | { schema: keyof Database },
  EnumName extends PublicEnumNameOrOptions extends { schema: keyof Database }
    ? keyof Database[PublicEnumNameOrOptions["schema"]]["Enums"]
    : never = never,
> = PublicEnumNameOrOptions extends { schema: keyof Database }
  ? Database[PublicEnumNameOrOptions["schema"]]["Enums"][EnumName]
  : PublicEnumNameOrOptions extends keyof PublicSchema["Enums"]
    ? PublicSchema["Enums"][PublicEnumNameOrOptions]
    : never

export type CompositeTypes<
  PublicCompositeTypeNameOrOptions extends
    | keyof PublicSchema["CompositeTypes"]
    | { schema: keyof Database },
  CompositeTypeName extends PublicCompositeTypeNameOrOptions extends {
    schema: keyof Database
  }
    ? keyof Database[PublicCompositeTypeNameOrOptions["schema"]]["CompositeTypes"]
    : never = never,
> = PublicCompositeTypeNameOrOptions extends { schema: keyof Database }
  ? Database[PublicCompositeTypeNameOrOptions["schema"]]["CompositeTypes"][CompositeTypeName]
  : PublicCompositeTypeNameOrOptions extends keyof PublicSchema["CompositeTypes"]
    ? PublicSchema["CompositeTypes"][PublicCompositeTypeNameOrOptions]
    : never
